use XML::LibXML;
use XML::SAX::IncrementalBuilder::LibXML;
use XML::Generator::XMPP;

my $xpc = XML::LibXML::XPathContext->new;
$xpc->registerNs('', 'jabber:client');
$xpc->registerNs('cl', 'jabber:client');
$xpc->registerNs('sasl', 'urn:ietf:params:xml:ns:xmpp-sasl');
$xpc->registerNs('pubsub', 'http://jabber.org/protocol/pubsub');
$xpc->registerNs ('stream', 'http://etherx.jabber.org/streams');

my $handler = XML::SAX::IncrementalBuilder::LibXML->new (detach => 1);
my $x = XML::Generator::XMPP->new(Handler => $handler, XPC => $xpc, Server => 'jabber.thuis');

my $client = 'cl';
my $pubsub = 'pubsub';
$x->start;
   $x->nodes([
      "$client:iq" => [
         Attributes => {
            "$client:to" => 'pubsub.khazad-dum.thuis',
            "$client:from" => $jid,
            "$client:type" => 'set',
         },
         Child => [
            "$pubsub:pubsub" => [
               Child => [
                  "$pubsub:publish" => [
                     Attributes => {
                        "$pubsub:node" => '/home/khazad-dum.thuis/martijn'
                     },
                     Child => [
                        "$pubsub:item" => [
                           Attributes => {
                              "$pubsub:id" => "id_" . $count++
                           },
                           #Subtree => $node,
                        ],
                     ],
                  ],
               ],
            ],
         ],
      ],
      "$client:iq" => [
         Attributes => {
            "$client:to" => 'pubsub.khazad-dum.thuis',
            "$client:from" => $jid,
            "$client:type" => 'set',
         },
         Child => [
            "$pubsub:pubsub" => [
               Child => [
                  "$pubsub:publish" => [
                     Attributes => {
                        "$pubsub:node" => '/home/khazad-dum.thuis/martijn'
                     },
                     Child => [
                        "$pubsub:item" => [
                           Attributes => {
                              "$pubsub:id" => "id_" . $count++
                           },
                           #Subtree => $node,
                        ],
                     ],
                  ],
               ],
            ],
         ],
      ],
   ]);
$x->end;
while (my $node = $handler->get_node) {
        print $node->toString;
}
#$x->print_pending;
__END__

$x->print_pending;
$x->nodes([
      'sasl:auth' => [Attributes => {'sasl:mechanism' => 'DIGEST-MD5'}],
   ]);
$x->print_pending;
$x->nodes([
      'sasl:response' => [Text => 'base64encodeddata'],
      'stream:foo' => [Text => '  ', Child => ['stream:bar' => []], Text => "\n  "],
   ]);
my $test = XML::LibXML::Element->new('foo');
$test->appendTextChild('bar' => 'baz');
$x->nodes([
	'sasl:quux' => [ Subtree => $test ],
]);
my $line = <STDIN>;
$x->end;
$x->print_pending;
