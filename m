Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE76EB106B
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 15:09:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AF237402DC;
	Tue, 10 Mar 2026 16:09:51 +0100 (CET)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id EB96C402BA
 for <dev@dpdk.org>; Tue, 10 Mar 2026 16:09:49 +0100 (CET)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-128d2e3082eso940846c88.0
 for <dev@dpdk.org>; Tue, 10 Mar 2026 08:09:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773155389; cv=none;
 d=google.com; s=arc-20240605;
 b=P6G41LDCWl7s9kKsCBu/RIZPLznv0/hhleLDNlqZs/QXV5efDVzC7uRM3slaLm0HPe
 zXewAf4+vqrAMx09frg63KQFpQPA1Rl+DEfYtW2dE+a1yT7aaray/ruRneDnNC729TYs
 ne2pd/iDh6mkWCOQaMUyXUdjyVz7txeRHn+TtqhWHmfGRpRptKPku/S18K7a072L4JBp
 1njs27Xlvnl3QVAigejJrJCumdC6IvNcmFGHptWkYopyTv71KewRNlPTSUBGzBV6C3La
 G0bYA7/zH/fqJq0UJo8jzkQUXJ+lKSIkqD/QMlKOF8hKfFifEIqMQwU7EJME3rDxbUhs
 dW+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9qA/jX/OWhev3Lh6PUm47dxzUONMcpt+Shrwa5u+p08=;
 fh=epCleMiZnVyEuOmsKHP+DWWGEzDHe5IcG+Tdi/8g4p4=;
 b=b+P3ByVFjXDWrXF1ILsMvbIu2K8HSwEsTU/D4fGQ1Pm+PnodsTOSEZtTIR2HoTTlDM
 8ZG+n3RPQsb3V/4KyGbQ3NRt3U0r3JwrbIiEhL0p/3sfTV/mkdrH2CWP/xHk1D4bsbb+
 9tAePOw7BmI/GaX8KNseYeymYjiU/pXv+4h2UC61wR8I6yaMP2g0cVyKgmbY3SbfQaUr
 xeHfWZgSun6qVyeV1iNFTCYhA7cl2VolJRCKk5UT29Br4VZz8NDXpU6CXuoABXU60wVL
 Su1kvyfQtuQpPCN8dOpUIalbi65tW/s/VsZBFz3sgq8kDPqAyoT+ZS2KZKzCVYyqSi2P
 AVAg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773155389; x=1773760189; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9qA/jX/OWhev3Lh6PUm47dxzUONMcpt+Shrwa5u+p08=;
 b=XTdNBaNRoZtG0+cGx8rOC3B12ZthCRZeyCSzD+viZ+drhI3/33Nttb+e3/tB6uUalz
 Iz8TNhFSBvCNK6ZS2/JOWw5p5o+Jk8DBK9yg/CBcIebHULE7M9rdfL2Ot8+u/sa1O6Hk
 U53XQ0C6DrQQbhTBnvy2Xm20ku8LIRCFXfC2Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773155389; x=1773760189;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9qA/jX/OWhev3Lh6PUm47dxzUONMcpt+Shrwa5u+p08=;
 b=cXBS0C9iKUWuBqxvgI02VhUc1ZFNi3/bd7gKDCzI0sEphVeAiL1N7gskXTjcMxOoIs
 XvPfPvkc0V/65OVQGPWdEqQ1l8XYA03Rr2s4CnUpzfZWQA8CRhtrvwUvmAEl1OQw5vr2
 TIOYLCP2ktpSEeKNipTY9cthKePvq09SBU2L2JVuIbmhpprrbxkyxJYCYniq0OkFDRlb
 OGiya7Wox7WTI5XSOoNVy+EIdLIUCajUbw6i5dFJfWSfgYa5Mmc5ifEtRAa5r8rgOc6g
 M85DwqM/8zAENv5S3JtQ4lC9fVTSPE+Nnw6bzV7aDKh9nAQjgVUVdlaZG4kvNvqKdiqr
 4jYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaHMKl2jI0ExB7hDNKGV6dq09itay5tCktGA8ukzL5I9mJ59CgzgFbEkiO1s5ScjeWMEM=@dpdk.org
X-Gm-Message-State: AOJu0YwQfEQkB2z0F4p1EKkG4GcOa3ycSYEPT5ndfad+XhiZ5ivl2wMY
 +N0JrrOev9rnWdS2kvmigQ5Jqq/+nlDdaz0qC37Ha/ljvFayhKstZWoAstbLJxvT+HQxJEW/Ajx
 0y6tDG5RgR1L4Z1VGqVMJu94gW0AKzP/b6M1wtFbKaw==
X-Gm-Gg: ATEYQzwn3PGT0pCyyhxpimT1pEKgBonEd5UYPdjeQOaLMQgZlgR71F75ZShyahu4n+X
 lASH/ptYDLADXCjOBm8AVK3VQ9bDCbm79RkYIT2ZSULAegadjx2O7uDGzqf/rYLZAaIPW3vPZr1
 u5WphD1rJ2l48tiT/9aSpqovx9TbkWmNNAsHFEpMo8TBDNaM/XdapgbFyYlFV1/3UFfNaO8wUiN
 c2g8fRjwJM/VkQgro/zq0UvLf0MXVTGzn9Kh2pnVmPi/58LoCrWA8SWLWNxxtic7PtYNYIZ5kz3
 1Izeqctoz/O3hMYWuHEckYTQFum6/0Sz8HONcFGNrvTxwGMAMfElGI9SrbrG0J7E36k0RATB
X-Received: by 2002:a05:7022:419:b0:11b:bf3f:5240 with SMTP id
 a92af1059eb24-128c2d8fb30mr7057540c88.9.1773155388890; Tue, 10 Mar 2026
 08:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20251121195511.322005-1-abailey@iol.unh.edu>
 <20251217165716.705128-1-abailey@iol.unh.edu>
 <CAJvnSUBd-Ywb5feeqQTDvVdsB_=4-BgdM5YkdGhOCTAJ2Gi2mA@mail.gmail.com>
In-Reply-To: <CAJvnSUBd-Ywb5feeqQTDvVdsB_=4-BgdM5YkdGhOCTAJ2Gi2mA@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 10 Mar 2026 11:06:47 -0400
X-Gm-Features: AaiRm52GYztes4sr-BDqUWurZNFCJTONv3nSl5gWF-iHZAgzmXqgo9MzY91vn8s
Message-ID: <CAJvnSUALWudn+Kqv3wptWAwuiws9H+P2_VYu8=q0P4V4_yoFJQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dts: make one link the default topology
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: dmarx@iol.unh.edu, dev@dpdk.org, Luca Vizzarro <Luca.Vizzarro@arm.com>
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

One more issue (that is probably not sniffer related) is that when
changing to 1 link, vlan_header_insertion testcase has an ERROR result
with: "Testpmd failed to set vlan insertion tag 51 on port 1." This
makes sense because usage of port 1 is hardcoded into the testcast -
we need to decorate this wil requires 2 links.

    @func_test
    def vlan_header_insertion(self) -> None:
        """Ensure that VLAN packet is received with the correct
inserted VLAN tag.

        Steps:
            * Start testpmd.
            * Set forwarding mode to MAC.
            * Disable promiscuous mode.
            * Enable Tx VLAN and set the VLAN tag.
            * Send and capture VLAN packets.

        Verify:
            * VLAN packets are received with the correct inserted VLAN tag.
        """
        with TestPmd() as testpmd:
            testpmd.set_forward_mode(SimpleForwardingModes.mac)
            testpmd.set_promisc(port=3D0, enable=3DFalse)
            testpmd.stop_all_ports()
            testpmd.tx_vlan_set(port=3D1, enable=3DTrue, vlan=3D51)
            testpmd.start_all_ports()
            testpmd.start()
            self._send_packet_and_verify_insertion(expected_id=3D51)

On Tue, Mar 10, 2026 at 10:53=E2=80=AFAM Patrick Robb <probb@iol.unh.edu> w=
rote:
>
> The implementation of the patch looks good to me, but I think the
> testsuites being reduced from 2 links to 1 link might be an incorrect
> set.
>
> For instance, I just did a testrun on cx7 comparing for-main to
> for-main + this series.
>
> This series introduces failures for:
> port control: start_ports testcase
> vlan: vlan_no_receipt testcase
> vlan: vlan_receipt_stripping testcase
>
> In terms of why these fails are happening... in principle the
> functions flexed by these testcases should be fine to test with 1
> link. My guess is we are uncovering an issue with the scapy sniffer
> when running a 1 link test. The port_control testcase fails because it
> expects 100 packets and sniffs 200. Perhaps this is because it is
> sniffing both tx and rx packets on the TG port 0. We have code to
> prevent this from the most recent implementation of the sniffer class
> but maybe it has a gap.
