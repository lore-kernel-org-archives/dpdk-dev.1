Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FE7C8303F
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 02:30:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC99B4021E;
	Tue, 26 Aug 2025 04:30:15 +0200 (CEST)
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by mails.dpdk.org (Postfix) with ESMTP id B4F2040156
 for <dev@dpdk.org>; Tue, 26 Aug 2025 04:30:13 +0200 (CEST)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-771e15ce64eso1260880b3a.0
 for <dev@dpdk.org>; Mon, 25 Aug 2025 19:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1756175413; x=1756780213; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8I9H/AVKRh1L9TwlSjKrCEZoaQFtIrbFD1ISLvo2TuI=;
 b=hQBjoYNaX3+CfrDL7bXpLeF7phNS5RzTyAW6nFsrq8mIt/aZ7grNqxtZkeFMsKLx5Z
 /cari+pl747rmABtlTpsggS2x0Jvs67LlEeQXhHP5iVd2imXzNthrhDURH1NR6V9MEkJ
 vpeomLFS/a9RVREq95a5IZEUXHf7Zjab1G2q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756175413; x=1756780213;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8I9H/AVKRh1L9TwlSjKrCEZoaQFtIrbFD1ISLvo2TuI=;
 b=VjaQzefAqbJ9VL1l+rmNyfbeexacTiZf2txlUjBmuZOMssEO/mgf+ZgC+ItQG3NYk4
 6bzRw4hSeTXtaq+kTTW9d67i0LVjvRp6R8/b6bKBbtob+9RgCEn64YOXXy7cX27NkVWH
 dgqGchjKuC3RwQf4MygiZ0MvREvVn0m5Qw7GSpgmc68FTKyuBPUZenQ+0VrOUegdS8Sh
 q0COLYPTxSutLWUWTvmIlsO0UCphXuIl4vo9VhGYFQSgUscxw8D7TCf/TxAoFSGP1Shz
 eCZ/SA/rKqgeCkcEio508x/8GcNwnl/g3u/xeEtRXlnOkok96vAfURpVTDG7jRwFhbvD
 5HlA==
X-Gm-Message-State: AOJu0YxNnyo4m8aMoWXGrANSrJsCe+jSzgnnrxQxBN0p5JT+3bCi9tLo
 a24Z2yhMo/aF4OTDM9Fhcny4cJKhukR0Al99m/l5Lyk572/PXL3hgLDf32kBpQ6Q9ddYMh1pGvT
 bWXxuDfz/bbWlEi/LGw5CH9fJii1NfwGkDxECsqD5Bg==
X-Gm-Gg: ASbGnctMGk4DdYtF5HMXUk7eDHsIZZWkhvvkyNh0g3FVwybVx0J61iM1y+el9cR0xdB
 htJG7Op+3/WLoEVbJ+ehaauSsQPyj78zm009SXkhMctslfu8iNM3WBOr3Iaiqnrd2Mq40L3OqJf
 /gEA9dMnrae3AiUTWQNp1YcDIARn22+KxVegOnHRSgSKQT0Fj1RU7Zhe6YagDJk5a2cc4jKOdJ9
 M/j8XHqlDRWkdptum3NkbLmV05vL1DAKR1CnkQ=
X-Google-Smtp-Source: AGHT+IEqxK7pqIimBeULYlBxmmFeQlO5MKi20pCMwjPdfSBJpQ16gIXjExO5ITC4XhtW07KNlMuf38to2MQkaqAyTSQ=
X-Received: by 2002:a17:903:1af0:b0:240:3ef:e17d with SMTP id
 d9443c01a7336-2462ef584edmr167941745ad.40.1756175412511; Mon, 25 Aug 2025
 19:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250718150404.200096-1-thomas.wilks@arm.com>
 <20250730125859.159185-1-thomas.wilks@arm.com>
 <20250730125859.159185-3-thomas.wilks@arm.com>
In-Reply-To: <20250730125859.159185-3-thomas.wilks@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Mon, 25 Aug 2025 22:23:36 -0400
X-Gm-Features: Ac12FXy2qi4mtFSuJBIPukrFR3yKJxUOvG_mgGeqnH3Tk4QnLKEEthldWYCTZsg
Message-ID: <CAJvnSUDKEV26wS=xOE2oVMfwOS3xqnTV-OP70PGfBNRcBCeGkQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dts: add PMD RSS testsuite
To: Thomas Wilks <thomas.wilks@arm.com>
Cc: dev@dpdk.org, Paul Szczepanek <paul.szczepanek@arm.com>, 
 Luca Vizzarro <luca.vizzarro@arm.com>, Ivan Malov <ivan.malov@arknetworks.am>, 
 Dean Marx <dmarx@iol.unh.edu>
Content-Type: multipart/alternative; boundary="000000000000a05d79063d3b732a"
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

--000000000000a05d79063d3b732a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 30, 2025 at 8:59=E2=80=AFAM Thomas Wilks <thomas.wilks@arm.com>=
 wrote:

>
> +    def configure_random_reta(self, testpmd: TestPmdShell, queue_number:
> int) -> list[int]:
> +        """Configure RETA to have random order of queues.
> +
> +        Args:
> +            testpmd: The testpmd instance that will be used to set the
> rss environment.
> +            queue_number: Number of queues that will be randomly inserte=
d
> into the RETA.
> +
> +        Returns:
> +            List of ids matching the configured RETA table
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If size of RETA table for
> driver is None.
> +        """
> +        reta_size =3D
> testpmd.show_port_info(port_id=3D0).redirection_table_size
> +        if reta_size is None:
> +            raise InteractiveCommandExecutionError("Size of RETA table
> for driver is None.")
> +        reta_table: list[int] =3D []
> +
> +        for i in range(reta_size):
> +            random_id =3D random.randint(0, queue_number - 1)
> +            reta_table.insert(i, random_id)
> +            testpmd.port_config_rss_reta(port_id=3D0, hash_index=3Di,
> queue_id=3Drandom_id)
>

I just did my testrun with a connectx5 NIC. It looks like it returned 4 for
redirection_table_size.

2025/08/25 22:04:04 - test_case - dts.lucian-cx5-SUT.TestPmdShell - INFO -
Sending: 'port config 0 rss reta (0,2)'
2025/08/25 22:04:04 - test_case - dts.lucian-cx5-SUT.TestPmdShell - INFO -
Sending: 'port config 0 rss reta (1,1)'
2025/08/25 22:04:04 - test_case - dts.lucian-cx5-SUT.TestPmdShell - INFO -
Sending: 'port config 0 rss reta (2,0)'
2025/08/25 22:04:04 - test_case - dts.lucian-cx5-SUT.TestPmdShell - INFO -
Sending: 'port config 0 rss reta (3,2)'

So, if the default queue size is 4, and the redirection_table_size is 4 in
this case, then there is a 1/(4^3), or 1/64 chance that all of the reta
table entries will be directed to the same queue. Should we enforce some
diversity of queues in the implementation?

I guess in principle even if all the hashes get associated with the same
queue the test would still be valid (it would show that all the packets get
directed to the same queue) but that seems moreso like testing an edge case
(which again, is valid) rather than testing the primary use case of RSS.
Another strategy might be like:

test1: enforce diversity of queue destinations for different hashes via the
implementation
test2: set random queue destinations for each hash (your current strategy)
test3: set the same queue destination for all hashes

What are your thoughts on this? And let me know if I'm misunderstanding
your strategy in any way.

+        return reta_table
> +
> +    def verify_rss_hash_function(
> +        self,
> +        testpmd: TestPmdShell,
> +        hash_algorithm: HashAlgorithm,
> +        flow_rule: FlowRule,
> +        reta: list[int],
> +    ) -> None:
> +        """Verifies hash function are working by sending test packets an=
d
> checking the packet queue.
> +
> +        Args:
> +            testpmd: The testpmd instance that will be used to set the
> rss environment.
> +            hash_algorithm: The hash algorithm to be tested.
> +            flow_rule: The flow rule that is to be validated and then
> created.
> +            reta: Will be used to calculate the predicted packet queues.
> +        """
> +        is_symmetric =3D hash_algorithm =3D=3D HashAlgorithm.SYMMETRIC_T=
OEPLITZ
> +        self.setup_rss_environment(testpmd)
> +        testpmd.flow_create(flow_rule, port_id=3D0)
> +        # Send udp packets and ensure hash corresponds with queue
> +        parsed_output =3D self.send_test_packets(
> +            testpmd, send_additional_mirrored_packet=3Dis_symmetric
> +        )
> +        self.verify_hash_queue(reta, parsed_output, is_symmetric)
> +
> +    @func_test
> +    def test_key_hash_algorithm(self) -> None:
> +        """Hashing algorithm test.
> +
> +        Steps:
> +            Setup RSS environment using the chosen algorithm.
> +            Send test packets for each flow rule.
> +
> +        Verify:
> +            Packet hash corresponds to the packet queue.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If size of RETA table for
> driver is None.
> +            InteractiveCommandExecutionError: If there are no valid flow
> rules that can be created.
> +        """
> +        failed_attempts: int =3D 0
> +        for algorithm in HashAlgorithm:
> +            flow_rule =3D FlowRule(
> +                group_id=3D0,
> +                direction=3D"ingress",
> +                pattern=3D["eth / ipv4 / udp"],
> +                actions=3D[f"rss types ipv4-udp end queues end func
> {algorithm.name.lower()}"],
> +            )
> +            with TestPmdShell(
> +                rx_queues=3Dself.config.NUM_QUEUES,
> +                tx_queues=3Dself.config.NUM_QUEUES,
> +            ) as testpmd:
> +                reta_table =3D self.configure_random_reta(testpmd,
> self.config.NUM_QUEUES)
> +
> +                if not testpmd.flow_validate(flow_rule, port_id=3D0):
> +                    # Queues need to be specified in the flow rule on
> some NICs
> +                    queue_ids =3D " ".join([str(x) for x in reta_table])
> +                    flow_rule.actions =3D [
> +                        f"rss types ipv4-udp end queues {queue_ids} end
> func "
> +                        + algorithm.name.lower()
> +                    ]
> +
> +                    if not testpmd.flow_validate(flow_rule, port_id=3D0)=
:
> +                        failed_attempts +=3D 1
> +                        if failed_attempts =3D=3D len(HashAlgorithm):
> +                            raise InteractiveCommandExecutionError(
> +                                "No Valid flow rule could be created."
> +                            )
> +                        # if neither rule format is valid then the
> algorithm is not supported,
> +                        # move to next one
> +                        continue
> +                self.verify_rss_hash_function(testpmd, algorithm,
> flow_rule, reta_table)
> +
> +    @func_test
> +    def test_update_key_set_hash_key_short_long(self) -> None:
> +        """Set hash key short long test.
> +
> +        Steps:
> +            Fetch the hash key size.
> +            Create two random hash keys one key too short and one too
> long.
> +
> +        Verify:
> +            Verify that it is not possible to set the shorter hash key.
> +            Verify that it is not possible to set the longer hash key.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If port info dose not
> contain hash key size.
> +        """
> +        with TestPmdShell(
> +            memory_channels=3D4,
> +            rx_queues=3Dself.config.NUM_QUEUES,
> +            tx_queues=3Dself.config.NUM_QUEUES,
> +        ) as testpmd:
> +            # Get RETA and key size
> +            port_info =3D testpmd.show_port_info(port_id=3D0)
> +
> +            # Get hash key size
> +            key_size =3D port_info.hash_key_size
> +            if key_size is None:
> +                raise InteractiveCommandExecutionError("Port info does
> not contain hash key size.")
> +
> +            # Create 2 hash keys based on the NIC capabilities
> +            short_key =3D "".join(
> +                [random.choice("0123456789ABCDEF") for n in
> range(key_size * 2 - 2)]
> +            )
> +            long_key =3D "".join([random.choice("0123456789ABCDEF") for =
n
> in range(key_size * 2 + 2)])
> +
> +            # Verify a short key cannot be set
> +            short_key_out =3D testpmd.port_config_rss_hash_key(
> +                0, RSSOffloadTypesFlag.ipv4_udp, short_key, False
> +            )
> +            self.verify(
> +                "invalid" in short_key_out,
> +                "Able to set hash key shorter than specified.",
> +            )
> +
> +            # Verify a long key cannot be set
> +            long_key_out =3D testpmd.port_config_rss_hash_key(
> +                0, RSSOffloadTypesFlag.ipv4_udp, long_key, False
> +            )
> +            self.verify("invalid" in long_key_out, "Able to set hash key
> longer than specified.")
> +
> +    @func_test
> +    def test_update_key_reported_key_size(self) -> None:
> +        """Verify reported hash key size is the same as the NIC
> capabilities.
> +
> +        Steps:
> +            Fetch the hash key size and compare to the actual key size.
> +
> +        Verify:
> +            Reported key size is the same as the actual key size.
> +        """
> +        with TestPmdShell() as testpmd:
> +            reported_key_size =3D
> testpmd.show_port_info(port_id=3D0).hash_key_size
> +            self.verify(
> +                reported_key_size =3D=3D self.config.ACTUAL_KEY_SIZE,
> +                "Reported key size is not the same as the config file.",
> +            )
> +
> +    @func_test
> +    def test_reta_key_reta_queues(self) -> None:
> +        """RETA rx/tx queues test.
> +
> +        Steps:
> +            For each queue size setup RSS environment and send Test
> packets.
>

Test should have lowercase t


> +
> +        Verify:
> +            Packet hash corresponds to hash queue.
> +
> +        Raises:
> +            InteractiveCommandExecutionError: If size of RETA table for
> driver is None.
> +        """
> +        queues_numbers =3D [2, 9, 16]
> +        for queue_number in queues_numbers:
>

I am a little confused by how this ran - maybe you can help. :)

The first iteration through, the reta size was 2, and it used a queue size
of 2.
The second iteration through, the reta size was 512, and the queue size was
9.
The third iteration through, the reta size was 16 and the queue size was 16=
.

Is this what you expect? I can't quite tell why the reta size was 512 in
the second case. If it matters, I didn't provide any tests_config.yaml for
this testsuite, so I was running from the default config.


> +            with TestPmdShell(
> +                rx_queues=3Dqueue_number,
> +                tx_queues=3Dqueue_number,
> +            ) as testpmd:
> +                # Configure the RETA with random queues
> +                reta =3D self.configure_random_reta(testpmd, queue_numbe=
r)
> +
> +                self.setup_rss_environment(testpmd)
> +
> +                # Send UDP packets and ensure hash corresponds with queu=
e
> +                parsed_output =3D self.send_test_packets(testpmd)
> +                self.verify_hash_queue(reta, parsed_output, False)
> +
> +    @func_test
> +    def test_reta_key_reported_reta_size(self) -> None:
> +        """Reported RETA size test.
> +
> +        Steps:
> +            Fetch reported reta size.
> +
> +        Verify:
> +            Reported RETA size is equal to the actual RETA size.
> +        """
> +        with TestPmdShell(
> +            rx_queues=3Dself.config.NUM_QUEUES,
> +            tx_queues=3Dself.config.NUM_QUEUES,
> +        ) as testpmd:
> +            reported_reta_size =3D
> testpmd.show_port_info(port_id=3D0).redirection_table_size
> +            self.verify(
> +                reported_reta_size =3D=3D self.config.ACTUAL_RETA_SIZE,
> +                "Reported RETA size is not the same as the config file."=
,
>

If we are going to have such a test I think this verify fail message should
be an f string which inserts the reported reta size and the reta size from
the config file. I think that's an improvement in general, and it also will
help with the fact that some users may not be accustomed to usage of
tests_config.yaml (yet).

At the same time, I want to thank you for making effective use of
tests_config in this testsuite. :)


> +            )
> --
> 2.43.0
>
>
Thanks a bunch Thomas - this looks good overall. Let me know what your
thoughts are on the comments and otherwise I think we are close to pushing
this.

--000000000000a05d79063d3b732a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jul 30,=
 2025 at 8:59=E2=80=AFAM Thomas Wilks &lt;<a href=3D"mailto:thomas.wilks@ar=
m.com">thomas.wilks@arm.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex"><br>
+=C2=A0 =C2=A0 def configure_random_reta(self, testpmd: TestPmdShell, queue=
_number: int) -&gt; list[int]:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Configure RETA to have rando=
m order of queues.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd: The testpmd instance th=
at will be used to set the rss environment.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queue_number: Number of queues t=
hat will be randomly inserted into the RETA.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Returns:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 List of ids matching the configu=
red RETA table<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If size of RETA table for driver is None.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 reta_size =3D testpmd.show_port_info(port_id=
=3D0).redirection_table_size<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if reta_size is None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutio=
nError(&quot;Size of RETA table for driver is None.&quot;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 reta_table: list[int] =3D []<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for i in range(reta_size):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 random_id =3D random.randint(0, =
queue_number - 1)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reta_table.insert(i, random_id)<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.port_config_rss_reta(por=
t_id=3D0, hash_index=3Di, queue_id=3Drandom_id)<br></blockquote><div><br></=
div><div>I just did my testrun with a connectx5 NIC. It looks like it retur=
ned 4 for redirection_table_size.</div><div><br></div><div>2025/08/25 22:04=
:04 - test_case - dts.lucian-cx5-SUT.TestPmdShell - INFO - Sending: &#39;po=
rt config 0 rss reta (0,2)&#39;<br>2025/08/25 22:04:04 - test_case - dts.lu=
cian-cx5-SUT.TestPmdShell - INFO - Sending: &#39;port config 0 rss reta (1,=
1)&#39;<br>2025/08/25 22:04:04 - test_case - dts.lucian-cx5-SUT.TestPmdShel=
l - INFO - Sending: &#39;port config 0 rss reta (2,0)&#39;<br>2025/08/25 22=
:04:04 - test_case - dts.lucian-cx5-SUT.TestPmdShell - INFO - Sending: &#39=
;port config 0 rss reta (3,2)&#39;</div><div><br></div><div>So, if the defa=
ult queue size is 4, and the redirection_table_size is 4 in this case, then=
 there is a 1/(4^3), or 1/64 chance that all of the reta table entries will=
 be directed to the same queue. Should we enforce some diversity of queues =
in the implementation?</div><div>=C2=A0</div><div>I guess in principle even=
 if all the hashes get associated with the same queue the test would still =
be valid (it would show that all the packets get directed to the same queue=
) but that seems moreso like testing an edge case (which again, is valid) r=
ather than testing the primary use case of RSS. Another strategy might be l=
ike:</div><div><br></div><div>test1: enforce diversity of queue destination=
s for different hashes via the implementation</div><div>test2: set random q=
ueue destinations for each hash (your current strategy)</div><div>test3: se=
t the same queue destination for all hashes</div><div><br></div><div>What a=
re your thoughts on this? And let me know if I&#39;m misunderstanding your =
strategy in any way.</div><div><br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 return reta_table<br>
+<br>
+=C2=A0 =C2=A0 def verify_rss_hash_function(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd: TestPmdShell,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hash_algorithm: HashAlgorithm,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_rule: FlowRule,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 reta: list[int],<br>
+=C2=A0 =C2=A0 ) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Verifies hash function are w=
orking by sending test packets and checking the packet queue.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Args:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd: The testpmd instance th=
at will be used to set the rss environment.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hash_algorithm: The hash algorit=
hm to be tested.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_rule: The flow rule that is=
 to be validated and then created.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reta: Will be used to calculate =
the predicted packet queues.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 is_symmetric =3D hash_algorithm =3D=3D HashAlg=
orithm.SYMMETRIC_TOEPLITZ<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.setup_rss_environment(testpmd)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd.flow_create(flow_rule, port_id=3D0)<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 # Send udp packets and ensure hash corresponds=
 with queue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 parsed_output =3D self.send_test_packets(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 testpmd, send_additional_mirrore=
d_packet=3Dis_symmetric<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify_hash_queue(reta, parsed_output, is=
_symmetric)<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def test_key_hash_algorithm(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Hashing algorithm test.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Setup RSS environment using the =
chosen algorithm.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Send test packets for each flow =
rule.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Packet hash corresponds to the p=
acket queue.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If size of RETA table for driver is None.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If there are no valid flow rules that can be created.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 failed_attempts: int =3D 0<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for algorithm in HashAlgorithm:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flow_rule =3D FlowRule(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 group_id=3D0,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 direction=3D&quot;=
ingress&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pattern=3D[&quot;e=
th / ipv4 / udp&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions=3D[f&quot;=
rss types ipv4-udp end queues end func {algorithm.name.lower()}&quot;],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmdShell(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_queues=3Dself.c=
onfig.NUM_QUEUES,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_queues=3Dself.c=
onfig.NUM_QUEUES,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ) as testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reta_table =3D sel=
f.configure_random_reta(testpmd, self.config.NUM_QUEUES)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if not testpmd.flo=
w_validate(flow_rule, port_id=3D0):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Qu=
eues need to be specified in the flow rule on some NICs<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 queu=
e_ids =3D &quot; &quot;.join([str(x) for x in reta_table])<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 flow=
_rule.actions =3D [<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 f&quot;rss types ipv4-udp end queues {queue_ids} end func &quot;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 + algorithm.name.lower()<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ]<br=
>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if n=
ot testpmd.flow_validate(flow_rule, port_id=3D0):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 failed_attempts +=3D 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if failed_attempts =3D=3D len(HashAlgorithm):<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveCommandExecutionError(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;No Valid flow rule could be cr=
eated.&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 # if neither rule format is valid then the algorithm is not supp=
orted,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 # move to next one<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 continue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify_rss_ha=
sh_function(testpmd, algorithm, flow_rule, reta_table)<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def test_update_key_set_hash_key_short_long(self) -&gt; None=
:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Set hash key short long test=
.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Fetch the hash key size.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Create two random hash keys one =
key too short and one too long.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify that it is not possible t=
o set the shorter hash key.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify that it is not possible t=
o set the longer hash key.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If port info dose not contain hash key size.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmdShell(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 memory_channels=3D4,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_queues=3Dself.config.NUM_QUEU=
ES,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_queues=3Dself.config.NUM_QUEU=
ES,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ) as testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Get RETA and key size<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 port_info =3D testpmd.show_port_=
info(port_id=3D0)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Get hash key size<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 key_size =3D port_info.hash_key_=
size<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if key_size is None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 raise InteractiveC=
ommandExecutionError(&quot;Port info does not contain hash key size.&quot;)=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Create 2 hash keys based on th=
e NIC capabilities<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 short_key =3D &quot;&quot;.join(=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [random.choice(&qu=
ot;0123456789ABCDEF&quot;) for n in range(key_size * 2 - 2)]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 long_key =3D &quot;&quot;.join([=
random.choice(&quot;0123456789ABCDEF&quot;) for n in range(key_size * 2 + 2=
)])<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Verify a short key cannot be s=
et<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 short_key_out =3D testpmd.port_c=
onfig_rss_hash_key(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, RSSOffloadTypes=
Flag.ipv4_udp, short_key, False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;invalid&quot=
; in short_key_out,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Able to set =
hash key shorter than specified.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Verify a long key cannot be se=
t<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 long_key_out =3D testpmd.port_co=
nfig_rss_hash_key(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, RSSOffloadTypes=
Flag.ipv4_udp, long_key, False<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(&quot;invalid&quot; =
in long_key_out, &quot;Able to set hash key longer than specified.&quot;)<b=
r>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def test_update_key_reported_key_size(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Verify reported hash key siz=
e is the same as the NIC capabilities.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Fetch the hash key size and comp=
are to the actual key size.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Reported key size is the same as=
 the actual key size.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmdShell() as testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reported_key_size =3D testpmd.sh=
ow_port_info(port_id=3D0).hash_key_size<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reported_key_size =
=3D=3D self.config.ACTUAL_KEY_SIZE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Reported key=
 size is not the same as the config file.&quot;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def test_reta_key_reta_queues(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;RETA rx/tx queues test.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 For each queue size setup RSS en=
vironment and send Test packets.<br></blockquote><div><br></div><div>Test s=
hould have lowercase t</div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204=
);padding-left:1ex">
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Packet hash corresponds to hash =
queue.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Raises:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 InteractiveCommandExecutionError=
: If size of RETA table for driver is None.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 queues_numbers =3D [2, 9, 16]<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 for queue_number in queues_numbers:<br></block=
quote><div><br></div><div>I am a little confused by how this ran - maybe yo=
u can help. :)</div><div><br></div><div>The first iteration through, the re=
ta size was 2, and it used a queue size of 2.</div><div>The second iteratio=
n through, the reta size was 512, and the queue size was 9.</div><div>The t=
hird iteration through, the reta size was 16 and the queue size was 16.</di=
v><div><br></div><div>Is this what you expect? I can&#39;t quite tell why t=
he reta size was 512 in the second case. If it matters, I didn&#39;t provid=
e any tests_config.yaml for this testsuite, so I was running from the defau=
lt config.</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmdShell(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_queues=3Dqueue_=
number,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_queues=3Dqueue_=
number,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ) as testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Configure the RE=
TA with random queues<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reta =3D self.conf=
igure_random_reta(testpmd, queue_number)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.setup_rss_env=
ironment(testpmd)<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 # Send UDP packets=
 and ensure hash corresponds with queue<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 parsed_output =3D =
self.send_test_packets(testpmd)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify_hash_q=
ueue(reta, parsed_output, False)<br>
+<br>
+=C2=A0 =C2=A0 @func_test<br>
+=C2=A0 =C2=A0 def test_reta_key_reported_reta_size(self) -&gt; None:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;Reported RETA size test.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Steps:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Fetch reported reta size.<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 Verify:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Reported RETA size is equal to t=
he actual RETA size.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;&quot;&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 with TestPmdShell(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 rx_queues=3Dself.config.NUM_QUEU=
ES,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 tx_queues=3Dself.config.NUM_QUEU=
ES,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ) as testpmd:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reported_reta_size =3D testpmd.s=
how_port_info(port_id=3D0).redirection_table_size<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 self.verify(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reported_reta_size=
 =3D=3D self.config.ACTUAL_RETA_SIZE,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;Reported RET=
A size is not the same as the config file.&quot;,<br></blockquote><div><br>=
</div><div>If we are going to have such a test I think this verify fail mes=
sage should be an f string which inserts the reported reta size and the ret=
a size from the config file. I think that&#39;s an improvement in general, =
and it also will help with the fact that some users may not be accustomed t=
o usage of tests_config.yaml (yet).=C2=A0</div><div><br></div><div>At the s=
ame time, I want to thank you for making effective use of tests_config in t=
his testsuite. :)</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pad=
ding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 )<br>
-- <br>
2.43.0<br>
<br></blockquote><div><br></div><div>Thanks a bunch Thomas - this looks goo=
d overall. Let me know what your thoughts are on the comments and otherwise=
 I think we are close to pushing this.</div><div>=C2=A0</div></div></div>

--000000000000a05d79063d3b732a--
