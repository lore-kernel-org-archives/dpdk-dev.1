Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A16DC3601E
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Apr 2025 03:15:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9004D40156;
	Mon, 14 Apr 2025 05:15:49 +0200 (CEST)
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43]) by mails.dpdk.org (Postfix) with ESMTP id 15957400D7
 for <dev@dpdk.org>; Mon, 14 Apr 2025 05:15:48 +0200 (CEST)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-2ff784dc055so3725639a91.1
 for <dev@dpdk.org>; Sun, 13 Apr 2025 20:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1744600547; x=1745205347; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WkYUQfjPxlnlNpLHAwO7HIRnQdDx6dAYGAbSIkJAJ90=;
 b=gPLDgudcs5TDapOh2rmp21Zaa6eJIhCvLGW3gsxR1yDIBkx6b5cHynntoqeMsQgwri
 d5tGdqfY33YtNztjcCIdWIYQ1cCs2dnc/edm3uQgdmaPUooLC8UtuM0jlFfv8w1BZD/g
 mWqjdGWRMApezQLiid1kwjdn1s76JGqNM+9bc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744600547; x=1745205347;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WkYUQfjPxlnlNpLHAwO7HIRnQdDx6dAYGAbSIkJAJ90=;
 b=tsy4WTE7JN6gPjTeoegfTI3OJecT1dM0oXOyKseZDA3jrsXnJ00ZmT4OIkxmWC3smV
 80sslwCNCDmaijqEZok7qCJbw+1YFeL4Wa3iIIQ2CXwTy30PgjwAscMXf1VbSJzX8VXJ
 L4nc/6MUMpVxf1MneMzikhuWjCG20oWFPSca0YFUxxJq3cBTj8YgByJw0Y9cEjzUJYID
 y7IE5VTE8ScsTkRnTxGWVjsj8FM3rdn+bEIUTDWgTI22iQywcU44Y8sdf09aHRsc7IDg
 aL3BTUwvV4fXyj2pWrrUvlAZ8Cw0Daf59gNi2BhVT8sm5HqjuesfFKtttQlT2k/KsulS
 a+3Q==
X-Gm-Message-State: AOJu0Yx+1Ho0X4+cEQWhvoHWmvLP6i8Krwvy3lt1QmqQ6PsU/eI3vNLb
 5RuIjemhHZgxtBBT1vaCXeorW0jny39OOmWfOj7LGpO4AWHY+5iOu4LdfSLOQbnW4i+/5Ye8wcj
 4q/Oiv1eo5WwpTh7j3SxBkVrhOpjuHLeZ1eExUneU9OvOWlTeCpM=
X-Gm-Gg: ASbGncvJS6uj3buO87RkE9Ne0XSHPGBoOkCAavgeWdEHQS4sNlOGOfIeTCCX8sDYL36
 gpzlQ4TETsZLNxptXKxy8UMUNhDdEZT8GgdJnO3iWRCUP7WCBPX41C0SP9+yqVQsdXqaja5bn6V
 oOK235VufUN1VLeFL3BLOkh8t7kKP8RoHyGOjkVA==
X-Google-Smtp-Source: AGHT+IFhq4e6nFYlNIplGBQbhxuUjTibuJNvxbsZ4zPYhfyiQa1i3ODJzDUvHrggqMkUxxtt8PP/9kEkSYkEng9c1gM=
X-Received: by 2002:a17:90b:180f:b0:2ff:4e90:3c55 with SMTP id
 98e67ed59e1d1-308237e167fmr13984043a91.27.1744600546599; Sun, 13 Apr 2025
 20:15:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240829125020.34341-1-alex.chapman@arm.com>
 <20250225153345.331216-1-thomas.wilks@arm.com>
 <20250225153345.331216-3-thomas.wilks@arm.com>
In-Reply-To: <20250225153345.331216-3-thomas.wilks@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Sun, 13 Apr 2025 23:11:34 -0400
X-Gm-Features: ATxdqUFsbShGMnfi7ym16s953yVQ_Z6esRSgAmhY0FFfNOZveuwGamOjfakhT2c
Message-ID: <CAJvnSUBC1=Nv8oNkkyjjqYYCoEiy7akUAwyWbj=1rEyV6tjhdA@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] dts: add utils for PMD RSS testsuites
To: Thomas Wilks <thomas.wilks@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>, 
 Luca Vizzarro <luca.vizzarro@arm.com>
Content-Type: multipart/alternative; boundary="000000000000db006b0632b47786"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

--000000000000db006b0632b47786
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Thomas and Alex.

On Tue, Feb 25, 2025 at 10:34=E2=80=AFAM Thomas Wilks <thomas.wilks@arm.com=
> wrote:

> From: Alex Chapman <alex.chapman@arm.com>
>
> To reduce the amount of maintenance and code duplication,
> common functionality between the rss_key_update, pmd_rss_reta
> and pmd_rss_hash test suites has been collated into a single
> file called rss_utils.
>
> It contains 3 main functions:
> 1. verify that a packets RSS hash correctly associates with
>     the packets RSS queue.
> 2. Send test packets specific to RSS, such as symmetric
>     packets that have the L4 port src and dst swapped.
> 3. The setting up of the RSS environment which is common
>     between all 3 tets suites.
>

tets -> test.


> Signed-off-by: Alex Chapman <alex.chapman@arm.com>
> Signed-off-by: Thomas Wilks <thomas.wilks@arm.com>
>
> Reviewed-by: Paul Szczepanek <paul.szczepanek@arm.com>
> ---
>  dts/tests/pmd_rss_utils.py | 195 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 195 insertions(+)
>  create mode 100644 dts/tests/pmd_rss_utils.py
>
> diff --git a/dts/tests/pmd_rss_utils.py b/dts/tests/pmd_rss_utils.py
> new file mode 100644
> index 0000000000..2d9b333859
> --- /dev/null
> +++ b/dts/tests/pmd_rss_utils.py
> @@ -0,0 +1,195 @@
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 Arm Limited
> +
> +"""PMD RSS Test Suite Utils.
> +
> +Utility functions for the pmd_rss_... test suite series
> +"""
> +
> +import random
> +
> +from scapy.layers.inet import IP, UDP
> +from scapy.layers.l2 import Ether
> +
> +from framework.exception import InteractiveCommandExecutionError
> +from framework.params.testpmd import SimpleForwardingModes
> +from framework.remote_session.testpmd_shell import (
> +    FlowRule,
> +    RSSOffloadTypesFlag,
> +    TestPmdShell,
> +    TestPmdVerbosePacket,
> +)
> +from framework.test_suite import TestSuite
> +
> +
> +def VerifyHashQueue(
>

Should be snake case - VerifyHashQueue -> verify_hash_queue.

And that applies to the later functions in this patch also.


> +    test_suite: TestSuite,
> +    reta: list[int],
> +    received_packets: list[TestPmdVerbosePacket],
> +    verify_packet_pairs: bool,
> +) -> None:
> +    """Verifies the packet hash corresponds to the packet queue.
> +
> +    Given the received packets in the verbose output, iterate through
> each packet.
> +    Lookup the packet hash in the RETA and get its intended queue.
> +    Verify the intended queue is the same as the actual queue the packet
> was received in.
> +    If the hash algorithm is symmetric, verify that pairs of packets hav=
e
> the same hash,
> +    as the pairs of packets sent have "mirrored" L4 ports.
> +    e.g. received_packets[0, 1, 2, 3, ...] hash(0) =3D hash(1), hash(2) =
=3D
> hash(3), ...
> +
> +    Args:
> +        test_suite: The reference to the currently running test suite.
> +        reta: Used to get predicted queue based on hash.
> +        received_packets: Packets received in the verbose output of
> testpmd.
> +        verify_packet_pairs: Verify pairs of packets have the same hash.
> +
> +    Raises:
> +        InteractiveCommandExecutionError: If packet_hash is None.
> +    """
> +    # List of packet hashes, used for symmetric algorithms
> +    hash_list =3D []
> +    for packet in received_packets:
> +        if packet.port_id !=3D 0 or packet.src_mac !=3D "02:00:00:00:00:=
00":
> +            continue
> +
> +        # Get packet hash
> +        packet_hash =3D packet.rss_hash
> +        if packet_hash is None:
> +            raise InteractiveCommandExecutionError(
> +                "Packet sent by the Traffic Generator has no RSS hash
> attribute."
> +            )
> +
> +        packet_queue =3D packet.rss_queue
> +
> +        # Calculate the predicted packet queue
> +        predicted_reta_index =3D packet_hash % len(reta)
> +        predicted_queue =3D reta[predicted_reta_index]
> +
> +        # Verify packets are in the correct queue
> +        test_suite.verify(
> +            predicted_queue =3D=3D packet_queue,
> +            "Packet sent by the Traffic Generator has no RSS queue
> attribute.",
> +        )
> +
> +        if verify_packet_pairs:
> +            hash_list.append(packet_hash)
> +
> +    if verify_packet_pairs:
> +        # Go through pairs of hashes in list and verify they are the sam=
e
> +        for odd_hash, even_hash in zip(hash_list[0::2], hash_list[1::2])=
:
> +            test_suite.verify(
> +                odd_hash =3D=3D even_hash,
> +                "Packet pair do not have same hash. Hash algorithm is no=
t
> symmetric.",
> +            )
> +
> +
> +def SendTestPackets(
>

Aside from the snake case, I think this function name could more clearly
indicate its purpose as it relates to RSS functions.


> +    TestSuite: TestSuite,
> +    testpmd: TestPmdShell,
> +    send_additional_mirrored_packet: bool,
> +) -> list[TestPmdVerbosePacket]:
> +    """Sends test packets.
> +
> +    Send 10 packets from the TG to SUT, parsing the verbose output and
> returning it.
> +    If the algorithm chosen is symmetric, send an additional packet for
> each initial
> +    packet sent, which has the L4 src and dst swapped.
> +
> +    Args:
> +        TestSuite: The reference to the currently running test suite.
> +        testpmd: Used to send packets and send commands to testpmd.
> +        send_additional_mirrored_packet: Send an additional mirrored
> packet for each packet sent.
> +
> +    Returns:
> +        TestPmdVerbosePacket: List of packets.
> +    """
> +    # Create test packets
> +    packets =3D []
> +    for i in range(10):
> +        packets.append(
> +            Ether(src=3D"02:00:00:00:00:00", dst=3D"11:00:00:00:00:00")
> +            / IP()
> +            / UDP(sport=3Di, dport=3Di + 1),
> +        )
> +        if send_additional_mirrored_packet:  # If symmetric, send the
> inverse packets
> +            packets.append(
> +                Ether(src=3D"02:00:00:00:00:00", dst=3D"11:00:00:00:00:0=
0")
> +                / IP()
> +                / UDP(sport=3Di + 1, dport=3Di),
> +            )
> +
> +    # Set verbose packet information and start packet capture
> +    testpmd.set_verbose(3)
> +    testpmd.start()
> +    testpmd.start_all_ports()
> +    TestSuite.send_packets_and_capture(packets)
> +
> +    # Stop packet capture and revert verbose packet information
> +    testpmd_shell_out =3D testpmd.stop()
> +    testpmd.set_verbose(0)
> +    # Parse the packets and return them
> +    return testpmd.extract_verbose_output(testpmd_shell_out)
> +
> +
> +def SetupRssEnvironment(
> +    TestSuite: TestSuite,
> +    testpmd: TestPmdShell,
> +    num_queues: int,
> +    flow_rule: FlowRule | None,
> +) -> tuple[list[int], int]:
> +    """Sets up the testpmd environment for RSS test suites.
> +
> +    This involves:
> +    1. Setting the testpmd forward mode to rx_only.
> +    2. Setting RSS on the NIC to UDP.
> +    3. Creating a flow if provided.
> +    4. Configuring RETA.
> +
> +    The reta and key_size of the NIC are then returned
> +
> +    Args:
> +        TestSuite: TestSuite environment.
> +        testpmd: Where the environment will be set.
> +        num_queues: Number of queues in the RETA table.
> +        flow_rule: The flow rule for altering packet fate.
> +
> +    Raises:
> +        InteractiveCommandExecutionError: If size of hash key for driver
> is None.
> +        InteractiveCommandExecutionError: If size of RETA table for
> driver is None.
> +
> +    Returns:
> +        reta: Configured Redirection Table.
> +        key_size: key size supported by NIC.
> +    """
> +    ports =3D []
> +    for port_id, _ in enumerate(TestSuite.topology.sut_ports):
> +        ports.append(port_id)
> +
> +    port_info =3D testpmd.show_port_info(ports[0])
> +
> +    # Get hash key size
> +    key_size =3D port_info.hash_key_size
> +    if key_size is None:
> +        raise InteractiveCommandExecutionError("Size of hash key for
> driver is None.")
> +
> +    # Get RETA table size
> +    reta_size =3D port_info.redirection_table_size
> +    if reta_size is None:
> +        raise InteractiveCommandExecutionError("Size of RETA table for
> driver is None.")
> +
> +    # Set forward mode to receive only, to remove forwarded packets from
> verbose output
> +    testpmd.set_forward_mode(SimpleForwardingModes.rxonly)
> +
> +    # Reset RSS settings and only RSS udp packets
> +    testpmd.port_config_all_rss_offload_type(RSSOffloadTypesFlag.udp)
> +
> +    # Create flow rule
> +    if flow_rule is not None:
> +        testpmd.flow_create(flow_rule, ports[0])
> +
> +    # Configure the RETA with random queues
> +    reta: list[int] =3D []
> +    for i in range(reta_size):
> +        reta.insert(i, random.randint(0, num_queues - 1))
> +        testpmd.port_config_rss_reta(ports[0], i, reta[i])
> +
> +    return reta, key_size
> --
> 2.43.0
>
>
Thanks, the function logic seems good.

I do want to reduce code duplication where possible, so having these
functions makes sense in principle. But, we have tried to maintain such
functions as a part of the testsuite class. So, I think that it would be
fine to move these functions to the testsuite class - but let me know what
you think.

Happy to discuss on Thursday at the DPDK CI meeting.

--000000000000db006b0632b47786
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Thanks Thomas and Alex.</div><br><div class=3D"gmail_=
quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, =
Feb 25, 2025 at 10:34=E2=80=AFAM Thomas Wilks &lt;<a href=3D"mailto:thomas.=
wilks@arm.com">thomas.wilks@arm.com</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">From: Alex Chapman &lt;<a href=3D"mailto=
:alex.chapman@arm.com" target=3D"_blank">alex.chapman@arm.com</a>&gt;<br>
<br>
To reduce the amount of maintenance and code duplication,<br>
common functionality between the rss_key_update, pmd_rss_reta<br>
and pmd_rss_hash test suites has been collated into a single<br>
file called rss_utils.<br>
<br>
It contains 3 main functions:<br>
1. verify that a packets RSS hash correctly associates with<br>
=C2=A0 =C2=A0 the packets RSS queue.<br>
2. Send test packets specific to RSS, such as symmetric<br>
=C2=A0 =C2=A0 packets that have the L4 port src and dst swapped.<br>
3. The setting up of the RSS environment which is common<br>
=C2=A0 =C2=A0 between all 3 tets suites.<br></blockquote><div><br></div><di=
v>tets -&gt; test.</div><div><br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">
<br>
Signed-off-by: Alex Chapman &lt;<a href=3D"mailto:alex.chapman@arm.com" tar=
get=3D"_blank">alex.chapman@arm.com</a>&gt;<br>
Signed-off-by: Thomas Wilks &lt;<a href=3D"mailto:thomas.wilks@arm.com" tar=
get=3D"_blank">thomas.wilks@arm.com</a>&gt;<br>
<br>
Reviewed-by: Paul Szczepanek &lt;<a href=3D"mailto:paul.szczepanek@arm.com"=
 target=3D"_blank">paul.szczepanek@arm.com</a>&gt;<br>
---<br>
=C2=A0dts/tests/pmd_rss_utils.py | 195 ++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A01 file changed, 195 insertions(+)<br>
=C2=A0create mode 100644 dts/tests/pmd_rss_utils.py<br>
<br>
diff --git a/dts/tests/pmd_rss_utils.py b/dts/tests/pmd_rss_utils.py<br>
new file mode 100644<br>
index 0000000000..2d9b333859<br>
--- /dev/null<br>
+++ b/dts/tests/pmd_rss_utils.py<br>
@@ -0,0 +1,195 @@<br>
+# SPDX-License-Identifier: BSD-3-Clause<br>
+# Copyright(c) 2025 Arm Limited<br>
+<br>
+&quot;&quot;&quot;PMD RSS Test Suite Utils.<br>
+<br>
+Utility functions for the pmd_rss_... test suite series<br>
+&quot;&quot;&quot;<br>
+<br>
+import random<br>
+<br>
+from scapy.layers.inet import IP, UDP<br>
+from scapy.layers.l2 import Ether<br>
+<br>
+from framework.exception import InteractiveCommandExecutionError<br>
+from framework.params.testpmd import SimpleForwardingModes<br>
+from framework.remote_session.testpmd_shell import (<br>
+=C2=A0 =C2=A0 FlowRule,<br>
+=C2=A0 =C2=A0 RSSOffloadTypesFlag,<br>
+=C2=A0 =C2=A0 TestPmdShell,<br>
+=C2=A0 =C2=A0 TestPmdVerbosePacket,<br>
+)<br>
+from framework.test_suite import TestSuite<br>
+<br>
+<br>
+def VerifyHashQueue(<br></blockquote><div><br></div><div>Should be snake c=
ase - VerifyHashQueue -&gt; verify_hash_queue.</div><div><br></div><div>And=
 that applies to the later functions in this patch also.</div><div>=C2=A0</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 test_suite: TestSuite,<br>
+=C2=A0 =C2=A0 reta: list[int],<br>
+=C2=A0 =C2=A0 received_packets: list[TestPmdVerbosePacket],<br>
+=C2=A0 =C2=A0 verify_packet_pairs: bool,<br>
+) -&gt; None:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Verifies the packet hash corresponds to th=
e packet queue.<br>
+<br>
+=C2=A0 =C2=A0 Given the received packets in the verbose output, iterate th=
rough each packet.<br>
+=C2=A0 =C2=A0 Lookup the packet hash in the RETA and get its intended queu=
e.<br>
+=C2=A0 =C2=A0 Verify the intended queue is the same as the actual queue th=
e packet was received in.<br>
+=C2=A0 =C2=A0 If the hash algorithm is symmetric, verify that pairs of pac=
kets have the same hash,<br>
+=C2=A0 =C2=A0 as the pairs of packets sent have &quot;mirrored&quot; L4 po=
rts.<br>
+=C2=A0 =C2=A0 e.g. received_packets[0, 1, 2, 3, ...] hash(0) =3D hash(1), =
hash(2) =3D hash(3), ...<br>
+<br>
+=C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_suite: The reference to the currently run=
ning test suite.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 reta: Used to get predicted queue based on has=
h.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 received_packets: Packets received in the verb=
ose output of testpmd.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 verify_packet_pairs: Verify pairs of packets h=
ave the same hash.<br>
+<br>
+=C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError: If packet_ha=
sh is None.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 # List of packet hashes, used for symmetric algorithms<br>
+=C2=A0 =C2=A0 hash_list =3D []<br>
+=C2=A0 =C2=A0 for packet in received_packets:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if packet.port_id !=3D 0 or packet.src_mac !=
=3D &quot;02:00:00:00:00:00&quot;:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Get packet hash<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet_hash =3D packet.rss_hash<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if packet_hash is None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutio=
nError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Packet sent =
by the Traffic Generator has no RSS hash attribute.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packet_queue =3D packet.rss_queue<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Calculate the predicted packet queue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 predicted_reta_index =3D packet_hash % len(ret=
a)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 predicted_queue =3D reta[predicted_reta_index]=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Verify packets are in the correct queue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 test_suite.verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 predicted_queue =3D=3D packet_qu=
eue,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Packet sent by the Traffic=
 Generator has no RSS queue attribute.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if verify_packet_pairs:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hash_list.append(packet_hash)<br=
>
+<br>
+=C2=A0 =C2=A0 if verify_packet_pairs:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Go through pairs of hashes in list and verif=
y they are the same<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for odd_hash, even_hash in zip(hash_list[0::2]=
, hash_list[1::2]):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 test_suite.verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 odd_hash =3D=3D ev=
en_hash,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Packet pair =
do not have same hash. Hash algorithm is not symmetric.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+<br>
+def SendTestPackets(<br></blockquote><div><br></div><div>Aside from the sn=
ake case, I think this function name could more clearly indicate its purpos=
e as it relates to RSS functions.</div><div>=C2=A0</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 TestSuite: TestSuite,<br>
+=C2=A0 =C2=A0 testpmd: TestPmdShell,<br>
+=C2=A0 =C2=A0 send_additional_mirrored_packet: bool,<br>
+) -&gt; list[TestPmdVerbosePacket]:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Sends test packets.<br>
+<br>
+=C2=A0 =C2=A0 Send 10 packets from the TG to SUT, parsing the verbose outp=
ut and returning it.<br>
+=C2=A0 =C2=A0 If the algorithm chosen is symmetric, send an additional pac=
ket for each initial<br>
+=C2=A0 =C2=A0 packet sent, which has the L4 src and dst swapped.<br>
+<br>
+=C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestSuite: The reference to the currently runn=
ing test suite.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd: Used to send packets and send command=
s to testpmd.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 send_additional_mirrored_packet: Send an addit=
ional mirrored packet for each packet sent.<br>
+<br>
+=C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestPmdVerbosePacket: List of packets.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 # Create test packets<br>
+=C2=A0 =C2=A0 packets =3D []<br>
+=C2=A0 =C2=A0 for i in range(10):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 packets.append(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether(src=3D&quot;02:00:00:00:00=
:00&quot;, dst=3D&quot;11:00:00:00:00:00&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / IP()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / UDP(sport=3Di, dport=3Di + 1),=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if send_additional_mirrored_packet:=C2=A0 # If=
 symmetric, send the inverse packets<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 packets.append(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Ether(src=3D&quot;=
02:00:00:00:00:00&quot;, dst=3D&quot;11:00:00:00:00:00&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / IP()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 / UDP(sport=3Di + =
1, dport=3Di),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 # Set verbose packet information and start packet capture<br=
>
+=C2=A0 =C2=A0 testpmd.set_verbose(3)<br>
+=C2=A0 =C2=A0 testpmd.start()<br>
+=C2=A0 =C2=A0 testpmd.start_all_ports()<br>
+=C2=A0 =C2=A0 TestSuite.send_packets_and_capture(packets)<br>
+<br>
+=C2=A0 =C2=A0 # Stop packet capture and revert verbose packet information<=
br>
+=C2=A0 =C2=A0 testpmd_shell_out =3D testpmd.stop()<br>
+=C2=A0 =C2=A0 testpmd.set_verbose(0)<br>
+=C2=A0 =C2=A0 # Parse the packets and return them<br>
+=C2=A0 =C2=A0 return testpmd.extract_verbose_output(testpmd_shell_out)<br>
+<br>
+<br>
+def SetupRssEnvironment(<br>
+=C2=A0 =C2=A0 TestSuite: TestSuite,<br>
+=C2=A0 =C2=A0 testpmd: TestPmdShell,<br>
+=C2=A0 =C2=A0 num_queues: int,<br>
+=C2=A0 =C2=A0 flow_rule: FlowRule | None,<br>
+) -&gt; tuple[list[int], int]:<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;Sets up the testpmd environment for RSS te=
st suites.<br>
+<br>
+=C2=A0 =C2=A0 This involves:<br>
+=C2=A0 =C2=A0 1. Setting the testpmd forward mode to rx_only.<br>
+=C2=A0 =C2=A0 2. Setting RSS on the NIC to UDP.<br>
+=C2=A0 =C2=A0 3. Creating a flow if provided.<br>
+=C2=A0 =C2=A0 4. Configuring RETA.<br>
+<br>
+=C2=A0 =C2=A0 The reta and key_size of the NIC are then returned<br>
+<br>
+=C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 TestSuite: TestSuite environment.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd: Where the environment will be set.<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 num_queues: Number of queues in the RETA table=
.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_rule: The flow rule for altering packet f=
ate.<br>
+<br>
+=C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError: If size of h=
ash key for driver is None.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError: If size of R=
ETA table for driver is None.<br>
+<br>
+=C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 reta: Configured Redirection Table.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 key_size: key size supported by NIC.<br>
+=C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 ports =3D []<br>
+=C2=A0 =C2=A0 for port_id, _ in enumerate(TestSuite.topology.sut_ports):<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ports.append(port_id)<br>
+<br>
+=C2=A0 =C2=A0 port_info =3D testpmd.show_port_info(ports[0])<br>
+<br>
+=C2=A0 =C2=A0 # Get hash key size<br>
+=C2=A0 =C2=A0 key_size =3D port_info.hash_key_size<br>
+=C2=A0 =C2=A0 if key_size is None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutionError(&quot;S=
ize of hash key for driver is None.&quot;)<br>
+<br>
+=C2=A0 =C2=A0 # Get RETA table size<br>
+=C2=A0 =C2=A0 reta_size =3D port_info.redirection_table_size<br>
+=C2=A0 =C2=A0 if reta_size is None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutionError(&quot;S=
ize of RETA table for driver is None.&quot;)<br>
+<br>
+=C2=A0 =C2=A0 # Set forward mode to receive only, to remove forwarded pack=
ets from verbose output<br>
+=C2=A0 =C2=A0 testpmd.set_forward_mode(SimpleForwardingModes.rxonly)<br>
+<br>
+=C2=A0 =C2=A0 # Reset RSS settings and only RSS udp packets<br>
+=C2=A0 =C2=A0 testpmd.port_config_all_rss_offload_type(RSSOffloadTypesFlag=
.udp)<br>
+<br>
+=C2=A0 =C2=A0 # Create flow rule<br>
+=C2=A0 =C2=A0 if flow_rule is not None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.flow_create(flow_rule, ports[0])<br>
+<br>
+=C2=A0 =C2=A0 # Configure the RETA with random queues<br>
+=C2=A0 =C2=A0 reta: list[int] =3D []<br>
+=C2=A0 =C2=A0 for i in range(reta_size):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 reta.insert(i, random.randint(0, num_queues - =
1))<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.port_config_rss_reta(ports[0], i, reta=
[i])<br>
+<br>
+=C2=A0 =C2=A0 return reta, key_size<br>
-- <br>
2.43.0<br>
<br></blockquote><div><br></div><div>Thanks, the function logic seems good.=
</div><div><br></div><div>I do want to reduce code duplication where possib=
le, so having these functions makes sense in principle. But, we have tried =
to maintain such functions as a part of the testsuite class. So, I think th=
at it would be fine to move these functions to the testsuite class - but le=
t me know what you think.</div><div><br></div><div>Happy to discuss on Thur=
sday at the DPDK CI meeting.</div><div>=C2=A0</div></div></div>

--000000000000db006b0632b47786--
