Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA4CC3ABD8
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 May 2025 20:21:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE381402DC;
	Wed, 14 May 2025 22:21:10 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id 088C5402C8
 for <dev@dpdk.org>; Wed, 14 May 2025 22:21:09 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-30a80e3222fso33172a91.3
 for <dev@dpdk.org>; Wed, 14 May 2025 13:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1747254068; x=1747858868; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Al4/+lepSgAXJv0Q1bj9OrZVIqq7RmywUyRErubgyM=;
 b=CJ+/ohUe1tPInM++lT4c8xLPj3L++AIwZZIYpJCDn356dc8cO9BjTXW1xTTzb13XID
 lKO6+3STXQboiRRgL85XBYhRrz65CTpaRUprevgFHHGfk9sd3PEFTvRPiNUkEDTbuebm
 Q6469PIAXIE5p7cIjLVDegLnjlcS9avfxG1p4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747254068; x=1747858868;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Al4/+lepSgAXJv0Q1bj9OrZVIqq7RmywUyRErubgyM=;
 b=XvAEIU/5QfYLUVxAXP3cH15aX01JpD5uNFlFn//oogRWE8IwP/2QtshcJBHBlgBt4c
 su0iKWRZNnVWgWwRm4rrDLT0ZEla1diuuTkVodEueaIf5OINhz4BEA0taO7uFHkna7Ez
 u2mZQ3i4m8AcbqyWekOoiINPRyblZ6c/FzR2cCYe4OzR14n/eoyHFRAXhulpLpAmNbDu
 Pcsu5KlHSM9jltfq5XRKxEGkkjV4ab8/3x+xuVUjMNNqf6w4ic2x2OtXE4Ez7xit/amh
 ex4+1KIFAe5W862KSETpDvZ7awYKNz221Jz3h7OddGrqicksacm6v25tE4N8rvkoZRwX
 soBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQPF/3EVHju2Jy4vBa1wr8ukq5+kHA8MeOf9dVaB5dWGuadQdi2/56a/yPBpDdbUf5LOc=@dpdk.org
X-Gm-Message-State: AOJu0Yz2NONU+1L4N48S9RpzWFmyEvNEoyk3K6/+u94XgpDnxDlfE72k
 4vrT5Xz5CnbxXiix1yG+gFxoW8ukVcCC4N96ABg0oJhe8gdCpYpuEwFKV/NOocWkwnLlTyzflxG
 pV1vjJAD4w7VJiDY4imNJo0iifTYjT06uUJG3KQ==
X-Gm-Gg: ASbGncsiZhB9cCuCo3FchcLtwEU47cycFyOFEtVdM0Kh8qARgB5OQpvtWQ5ecteoaL7
 2t8YAqGjfSgbfnz4mEL8/arpnveCYytna8ZoRuXZzVzHyCmzeEcS15VGjFWJgIXr2hDUP5c4qAG
 TsSaP2fovMm/l492Gz8kvjciLMjLCgoJ5wtpwS6sFaVXn9if8q
X-Google-Smtp-Source: AGHT+IG+w2glKXYTxwYf6hPz8K/eBy0iy/2KAaxSvxvJgkRdTztWgXGoixAOfNO+xkFhpVivp8s4FqD6+MTsYCxj7nI=
X-Received: by 2002:a17:90b:1b06:b0:2ee:acea:9ec4 with SMTP id
 98e67ed59e1d1-30e2e6229d3mr2717445a91.3.1747254067982; Wed, 14 May 2025
 13:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250306214747.579340-1-dmarx@iol.unh.edu>
 <20250306214747.579340-3-dmarx@iol.unh.edu>
In-Reply-To: <20250306214747.579340-3-dmarx@iol.unh.edu>
From: Nicholas Pratte <npratte@iol.unh.edu>
Date: Wed, 14 May 2025 16:20:57 -0400
X-Gm-Features: AX0GCFv7fn5GtKblA344QwXGbaf0OgSLGeE-xUFW_zpS_r4ADB1eyklx1XU6mig
Message-ID: <CAKXZ7ehY9DhyF2RTnEtM8Nx9eOLefJ_WMa_AA0g65eF2a4ZbZA@mail.gmail.com>
Subject: Re: [PATCH v1 2/4] dts: change verification field in checksum offload
 suite
To: Dean Marx <dmarx@iol.unh.edu>
Cc: probb@iol.unh.edu, luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Reviewed-by: Nicholas Pratte <npratte@iol.unh.edu>

On Thu, Mar 6, 2025 at 4:47=E2=80=AFPM Dean Marx <dmarx@iol.unh.edu> wrote:
>
> Changes the checksum offload testing suite to use layer 4
> destination ports as packet verification IDs.
>
> Signed-off-by: Dean Marx <dmarx@iol.unh.edu>
> ---
>  dts/tests/TestSuite_checksum_offload.py | 130 ++++++++++++++----------
>  1 file changed, 77 insertions(+), 53 deletions(-)
>
> diff --git a/dts/tests/TestSuite_checksum_offload.py b/dts/tests/TestSuit=
e_checksum_offload.py
> index b38d73421b..83879b0512 100644
> --- a/dts/tests/TestSuite_checksum_offload.py
> +++ b/dts/tests/TestSuite_checksum_offload.py
> @@ -70,7 +70,7 @@ def send_packets_and_verify(
>              )
>
>      def send_packet_and_verify_checksum(
> -        self, packet: Packet, good_L4: bool, good_IP: bool, testpmd: Tes=
tPmdShell, id: str
> +        self, packet: Packet, good_L4: bool, good_IP: bool, testpmd: Tes=
tPmdShell, id: int
>      ) -> None:
>          """Send packet and verify verbose output matches expected output=
.
>
> @@ -81,13 +81,13 @@ def send_packet_and_verify_checksum(
>              good_IP: Verifies RTE_MBUF_F_RX_IP_CKSUM_GOOD in verbose out=
put
>                  if :data:`True`, or RTE_MBUF_F_RX_IP_CKSUM_UNKNOWN if :d=
ata:`False`.
>              testpmd: Testpmd shell session to analyze verbose output of.
> -            id: The destination mac address that matches the sent packet=
 in verbose output.
> +            id: The destination port that matches the sent packet in ver=
bose output.
>          """
>          testpmd.start()
>          self.send_packet_and_capture(packet=3Dpacket)
>          verbose_output =3D testpmd.extract_verbose_output(testpmd.stop()=
)
>          for testpmd_packet in verbose_output:
> -            if testpmd_packet.dst_mac =3D=3D id:
> +            if testpmd_packet.l4_dport =3D=3D id:
>                  is_IP =3D PacketOffloadFlag.RTE_MBUF_F_RX_IP_CKSUM_GOOD =
in testpmd_packet.ol_flags
>                  is_L4 =3D PacketOffloadFlag.RTE_MBUF_F_RX_L4_CKSUM_GOOD =
in testpmd_packet.ol_flags
>          self.verify(is_L4 =3D=3D good_L4, "Layer 4 checksum flag did not=
 match expected checksum flag.")
> @@ -120,13 +120,13 @@ def test_insert_checksums(self) -> None:
>              Verify packets are received.
>              Verify packet checksums match the expected flags.
>          """
> -        mac_id =3D "00:00:00:00:00:01"
> +        dport_id =3D 50000
>          payload =3D b"xxxxx"
>          packet_list =3D [
> -            Ether(dst=3Dmac_id) / IP() / UDP() / Raw(payload),
> -            Ether(dst=3Dmac_id) / IP() / TCP() / Raw(payload),
> -            Ether(dst=3Dmac_id) / IPv6(src=3D"::1") / UDP() / Raw(payloa=
d),
> -            Ether(dst=3Dmac_id) / IPv6(src=3D"::1") / TCP() / Raw(payloa=
d),
> +            Ether() / IP() / UDP(dport=3Ddport_id) / Raw(payload),
> +            Ether() / IP() / TCP(dport=3Ddport_id) / Raw(payload),
> +            Ether() / IPv6(src=3D"::1") / UDP(dport=3Ddport_id) / Raw(pa=
yload),
> +            Ether() / IPv6(src=3D"::1") / TCP(dport=3Ddport_id) / Raw(pa=
yload),
>          ]
>          with TestPmdShell(enable_rx_cksum=3DTrue) as testpmd:
>              testpmd.set_forward_mode(SimpleForwardingModes.csum)
> @@ -136,7 +136,7 @@ def test_insert_checksums(self) -> None:
>              self.send_packets_and_verify(packet_list=3Dpacket_list, load=
=3Dpayload, should_receive=3DTrue)
>              for i in range(0, len(packet_list)):
>                  self.send_packet_and_verify_checksum(
> -                    packet=3Dpacket_list[i], good_L4=3DTrue, good_IP=3DT=
rue, testpmd=3Dtestpmd, id=3Dmac_id
> +                    packet=3Dpacket_list[i], good_L4=3DTrue, good_IP=3DT=
rue, testpmd=3Dtestpmd, id=3Ddport_id
>                  )
>
>      @func_test
> @@ -152,13 +152,13 @@ def test_no_insert_checksums(self) -> None:
>              Verify packets are received.
>              Verify packet checksums match the expected flags.
>          """
> -        mac_id =3D "00:00:00:00:00:01"
> +        dport_id =3D 50000
>          payload =3D b"xxxxx"
>          packet_list =3D [
> -            Ether(dst=3Dmac_id) / IP() / UDP() / Raw(payload),
> -            Ether(dst=3Dmac_id) / IP() / TCP() / Raw(payload),
> -            Ether(dst=3Dmac_id) / IPv6(src=3D"::1") / UDP() / Raw(payloa=
d),
> -            Ether(dst=3Dmac_id) / IPv6(src=3D"::1") / TCP() / Raw(payloa=
d),
> +            Ether() / IP() / UDP(dport=3Ddport_id) / Raw(payload),
> +            Ether() / IP() / TCP(dport=3Ddport_id) / Raw(payload),
> +            Ether() / IPv6(src=3D"::1") / UDP(dport=3Ddport_id) / Raw(pa=
yload),
> +            Ether() / IPv6(src=3D"::1") / TCP(dport=3Ddport_id) / Raw(pa=
yload),
>          ]
>          with TestPmdShell(enable_rx_cksum=3DTrue) as testpmd:
>              testpmd.set_forward_mode(SimpleForwardingModes.csum)
> @@ -167,7 +167,7 @@ def test_no_insert_checksums(self) -> None:
>              self.send_packets_and_verify(packet_list=3Dpacket_list, load=
=3Dpayload, should_receive=3DTrue)
>              for i in range(0, len(packet_list)):
>                  self.send_packet_and_verify_checksum(
> -                    packet=3Dpacket_list[i], good_L4=3DTrue, good_IP=3DT=
rue, testpmd=3Dtestpmd, id=3Dmac_id
> +                    packet=3Dpacket_list[i], good_L4=3DTrue, good_IP=3DT=
rue, testpmd=3Dtestpmd, id=3Ddport_id
>                  )
>
>      @func_test
> @@ -183,12 +183,12 @@ def test_l4_rx_checksum(self) -> None:
>          Verify:
>              Verify packet checksums match the expected flags.
>          """
> -        mac_id =3D "00:00:00:00:00:01"
> +        dport_id =3D 50000
>          packet_list =3D [
> -            Ether(dst=3Dmac_id) / IP() / UDP(),
> -            Ether(dst=3Dmac_id) / IP() / TCP(),
> -            Ether(dst=3Dmac_id) / IP() / UDP(chksum=3D0xF),
> -            Ether(dst=3Dmac_id) / IP() / TCP(chksum=3D0xF),
> +            Ether() / IP() / UDP(dport=3Ddport_id),
> +            Ether() / IP() / TCP(dport=3Ddport_id),
> +            Ether() / IP() / UDP(chksum=3D0xF, dport=3Ddport_id),
> +            Ether() / IP() / TCP(chksum=3D0xF, dport=3Ddport_id),
>          ]
>          with TestPmdShell(enable_rx_cksum=3DTrue) as testpmd:
>              testpmd.set_forward_mode(SimpleForwardingModes.csum)
> @@ -196,11 +196,11 @@ def test_l4_rx_checksum(self) -> None:
>              self.setup_hw_offload(testpmd=3Dtestpmd)
>              for i in range(0, 2):
>                  self.send_packet_and_verify_checksum(
> -                    packet=3Dpacket_list[i], good_L4=3DTrue, good_IP=3DT=
rue, testpmd=3Dtestpmd, id=3Dmac_id
> +                    packet=3Dpacket_list[i], good_L4=3DTrue, good_IP=3DT=
rue, testpmd=3Dtestpmd, id=3Ddport_id
>                  )
>              for i in range(2, 4):
>                  self.send_packet_and_verify_checksum(
> -                    packet=3Dpacket_list[i], good_L4=3DFalse, good_IP=3D=
True, testpmd=3Dtestpmd, id=3Dmac_id
> +                    packet=3Dpacket_list[i], good_L4=3DFalse, good_IP=3D=
True, testpmd=3Dtestpmd, id=3Ddport_id
>                  )
>
>      @func_test
> @@ -216,12 +216,12 @@ def test_l3_rx_checksum(self) -> None:
>          Verify:
>              Verify packet checksums match the expected flags.
>          """
> -        mac_id =3D "00:00:00:00:00:01"
> +        dport_id =3D 50000
>          packet_list =3D [
> -            Ether(dst=3Dmac_id) / IP() / UDP(),
> -            Ether(dst=3Dmac_id) / IP() / TCP(),
> -            Ether(dst=3Dmac_id) / IP(chksum=3D0xF) / UDP(),
> -            Ether(dst=3Dmac_id) / IP(chksum=3D0xF) / TCP(),
> +            Ether() / IP() / UDP(dport=3Ddport_id),
> +            Ether() / IP() / TCP(dport=3Ddport_id),
> +            Ether() / IP(chksum=3D0xF) / UDP(dport=3Ddport_id),
> +            Ether() / IP(chksum=3D0xF) / TCP(dport=3Ddport_id),
>          ]
>          with TestPmdShell(enable_rx_cksum=3DTrue) as testpmd:
>              testpmd.set_forward_mode(SimpleForwardingModes.csum)
> @@ -229,11 +229,11 @@ def test_l3_rx_checksum(self) -> None:
>              self.setup_hw_offload(testpmd=3Dtestpmd)
>              for i in range(0, 2):
>                  self.send_packet_and_verify_checksum(
> -                    packet=3Dpacket_list[i], good_L4=3DTrue, good_IP=3DT=
rue, testpmd=3Dtestpmd, id=3Dmac_id
> +                    packet=3Dpacket_list[i], good_L4=3DTrue, good_IP=3DT=
rue, testpmd=3Dtestpmd, id=3Ddport_id
>                  )
>              for i in range(2, 4):
>                  self.send_packet_and_verify_checksum(
> -                    packet=3Dpacket_list[i], good_L4=3DTrue, good_IP=3DF=
alse, testpmd=3Dtestpmd, id=3Dmac_id
> +                    packet=3Dpacket_list[i], good_L4=3DTrue, good_IP=3DF=
alse, testpmd=3Dtestpmd, id=3Ddport_id
>                  )
>
>      @func_test
> @@ -249,16 +249,16 @@ def test_validate_rx_checksum(self) -> None:
>          Verify:
>              Verify packet checksums match the expected flags.
>          """
> -        mac_id =3D "00:00:00:00:00:01"
> +        dport_id =3D 50000
>          packet_list =3D [
> -            Ether(dst=3Dmac_id) / IP() / UDP(),
> -            Ether(dst=3Dmac_id) / IP() / TCP(),
> -            Ether(dst=3Dmac_id) / IPv6(src=3D"::1") / UDP(),
> -            Ether(dst=3Dmac_id) / IPv6(src=3D"::1") / TCP(),
> -            Ether(dst=3Dmac_id) / IP(chksum=3D0x0) / UDP(chksum=3D0xF),
> -            Ether(dst=3Dmac_id) / IP(chksum=3D0x0) / TCP(chksum=3D0xF),
> -            Ether(dst=3Dmac_id) / IPv6(src=3D"::1") / UDP(chksum=3D0xF),
> -            Ether(dst=3Dmac_id) / IPv6(src=3D"::1") / TCP(chksum=3D0xF),
> +            Ether() / IP() / UDP(dport=3Ddport_id),
> +            Ether() / IP() / TCP(dport=3Ddport_id),
> +            Ether() / IPv6(src=3D"::1") / UDP(dport=3Ddport_id),
> +            Ether() / IPv6(src=3D"::1") / TCP(dport=3Ddport_id),
> +            Ether() / IP(chksum=3D0x0) / UDP(chksum=3D0xF, dport=3Ddport=
_id),
> +            Ether() / IP(chksum=3D0x0) / TCP(chksum=3D0xF, dport=3Ddport=
_id),
> +            Ether() / IPv6(src=3D"::1") / UDP(chksum=3D0xF, dport=3Ddpor=
t_id),
> +            Ether() / IPv6(src=3D"::1") / TCP(chksum=3D0xF, dport=3Ddpor=
t_id),
>          ]
>          with TestPmdShell(enable_rx_cksum=3DTrue) as testpmd:
>              testpmd.set_forward_mode(SimpleForwardingModes.csum)
> @@ -266,15 +266,19 @@ def test_validate_rx_checksum(self) -> None:
>              self.setup_hw_offload(testpmd=3Dtestpmd)
>              for i in range(0, 4):
>                  self.send_packet_and_verify_checksum(
> -                    packet=3Dpacket_list[i], good_L4=3DTrue, good_IP=3DT=
rue, testpmd=3Dtestpmd, id=3Dmac_id
> +                    packet=3Dpacket_list[i], good_L4=3DTrue, good_IP=3DT=
rue, testpmd=3Dtestpmd, id=3Ddport_id
>                  )
>              for i in range(4, 6):
>                  self.send_packet_and_verify_checksum(
> -                    packet=3Dpacket_list[i], good_L4=3DFalse, good_IP=3D=
False, testpmd=3Dtestpmd, id=3Dmac_id
> +                    packet=3Dpacket_list[i],
> +                    good_L4=3DFalse,
> +                    good_IP=3DFalse,
> +                    testpmd=3Dtestpmd,
> +                    id=3Ddport_id,
>                  )
>              for i in range(6, 8):
>                  self.send_packet_and_verify_checksum(
> -                    packet=3Dpacket_list[i], good_L4=3DFalse, good_IP=3D=
True, testpmd=3Dtestpmd, id=3Dmac_id
> +                    packet=3Dpacket_list[i], good_L4=3DFalse, good_IP=3D=
True, testpmd=3Dtestpmd, id=3Ddport_id
>                  )
>
>      @requires(NicCapability.RX_OFFLOAD_VLAN)
> @@ -291,13 +295,29 @@ def test_vlan_checksum(self) -> None:
>          Verify:
>              Verify packet checksums match the expected flags.
>          """
> -        mac_id =3D "00:00:00:00:00:01"
> +        dport_id =3D 50000
>          payload =3D b"xxxxx"
>          packet_list =3D [
> -            Ether(dst=3Dmac_id) / Dot1Q(vlan=3D1) / IP(chksum=3D0x0) / U=
DP(chksum=3D0xF) / Raw(payload),
> -            Ether(dst=3Dmac_id) / Dot1Q(vlan=3D1) / IP(chksum=3D0x0) / T=
CP(chksum=3D0xF) / Raw(payload),
> -            Ether(dst=3Dmac_id) / Dot1Q(vlan=3D1) / IPv6(src=3D"::1") / =
UDP(chksum=3D0xF) / Raw(payload),
> -            Ether(dst=3Dmac_id) / Dot1Q(vlan=3D1) / IPv6(src=3D"::1") / =
TCP(chksum=3D0xF) / Raw(payload),
> +            Ether()
> +            / Dot1Q(vlan=3D1)
> +            / IP(chksum=3D0x0)
> +            / UDP(chksum=3D0xF, dport=3Ddport_id)
> +            / Raw(payload),
> +            Ether()
> +            / Dot1Q(vlan=3D1)
> +            / IP(chksum=3D0x0)
> +            / TCP(chksum=3D0xF, dport=3Ddport_id)
> +            / Raw(payload),
> +            Ether()
> +            / Dot1Q(vlan=3D1)
> +            / IPv6(src=3D"::1")
> +            / UDP(chksum=3D0xF, dport=3Ddport_id)
> +            / Raw(payload),
> +            Ether()
> +            / Dot1Q(vlan=3D1)
> +            / IPv6(src=3D"::1")
> +            / TCP(chksum=3D0xF, dport=3Ddport_id)
> +            / Raw(payload),
>          ]
>          with TestPmdShell(enable_rx_cksum=3DTrue) as testpmd:
>              testpmd.set_forward_mode(SimpleForwardingModes.csum)
> @@ -307,11 +327,15 @@ def test_vlan_checksum(self) -> None:
>              self.send_packets_and_verify(packet_list=3Dpacket_list, load=
=3Dpayload, should_receive=3DTrue)
>              for i in range(0, 2):
>                  self.send_packet_and_verify_checksum(
> -                    packet=3Dpacket_list[i], good_L4=3DFalse, good_IP=3D=
False, testpmd=3Dtestpmd, id=3Dmac_id
> +                    packet=3Dpacket_list[i],
> +                    good_L4=3DFalse,
> +                    good_IP=3DFalse,
> +                    testpmd=3Dtestpmd,
> +                    id=3Ddport_id,
>                  )
>              for i in range(2, 4):
>                  self.send_packet_and_verify_checksum(
> -                    packet=3Dpacket_list[i], good_L4=3DFalse, good_IP=3D=
True, testpmd=3Dtestpmd, id=3Dmac_id
> +                    packet=3Dpacket_list[i], good_L4=3DFalse, good_IP=3D=
True, testpmd=3Dtestpmd, id=3Ddport_id
>                  )
>
>      @requires(NicCapability.RX_OFFLOAD_SCTP_CKSUM)
> @@ -328,10 +352,10 @@ def test_validate_sctp_checksum(self) -> None:
>          Verify:
>              Verify packet checksums match the expected flags.
>          """
> -        mac_id =3D "00:00:00:00:00:01"
> +        dport_id =3D 50000
>          packet_list =3D [
> -            Ether(dst=3Dmac_id) / IP() / SCTP(),
> -            Ether(dst=3Dmac_id) / IP() / SCTP(chksum=3D0xF),
> +            Ether() / IP() / UDP(dport=3Ddport_id) / SCTP(),
> +            Ether() / IP() / UDP(dport=3Ddport_id) / SCTP(chksum=3D0xF),
>          ]
>          with TestPmdShell(enable_rx_cksum=3DTrue) as testpmd:
>              testpmd.set_forward_mode(SimpleForwardingModes.csum)
> @@ -339,8 +363,8 @@ def test_validate_sctp_checksum(self) -> None:
>              testpmd.csum_set_hw(layers=3DChecksumOffloadOptions.sctp)
>              testpmd.start()
>              self.send_packet_and_verify_checksum(
> -                packet=3Dpacket_list[0], good_L4=3DTrue, good_IP=3DTrue,=
 testpmd=3Dtestpmd, id=3Dmac_id
> +                packet=3Dpacket_list[0], good_L4=3DTrue, good_IP=3DTrue,=
 testpmd=3Dtestpmd, id=3Ddport_id
>              )
>              self.send_packet_and_verify_checksum(
> -                packet=3Dpacket_list[1], good_L4=3DFalse, good_IP=3DTrue=
, testpmd=3Dtestpmd, id=3Dmac_id
> +                packet=3Dpacket_list[1], good_L4=3DFalse, good_IP=3DTrue=
, testpmd=3Dtestpmd, id=3Ddport_id
>              )
> --
> 2.48.1
>
