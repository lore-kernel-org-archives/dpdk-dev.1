Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2448EB1060
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 15:11:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C2BEB402DC;
	Tue, 10 Mar 2026 16:11:24 +0100 (CET)
Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
 by mails.dpdk.org (Postfix) with ESMTP id 615AF402BA
 for <dev@dpdk.org>; Tue, 10 Mar 2026 16:11:23 +0100 (CET)
Received: by mail-dl1-f54.google.com with SMTP id
 a92af1059eb24-128cc4b4b6aso169149c88.0
 for <dev@dpdk.org>; Tue, 10 Mar 2026 08:11:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773155482; cv=none;
 d=google.com; s=arc-20240605;
 b=hQhmZjZmLlEZoRuoN2V7OQF7puFkoMRKOthbTNgA4G8JH4ttuJhhqFxfp8O53IgtxP
 pG4BIdJESTlFUt45yrTdCEgMRRWQ8+qLkNYtYlmYbr8Ige1DTByVytrRwzR4SoiadwZG
 WHrADMME0Zgjyh8nPn15DrjPKQfsf6WeGuF1AmHt7ZQB2bync8qwEYxM6GVct0nEthn4
 QQOEZc0aQ39SaPHVmOZ1KZIikEFNyI2sBRlqbP6Ys9dhElhNjCX5YwMTfXhJUgyBkgpL
 kXDcB1Z19IbsgQ4FS0b1pMAihYoPq2rSH5LdI8CIJ7t3hV7Hz3BO3gHyUNL9zbzGUGMW
 UEtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=VWC4XeaSStWmWq9uFVpFYeeb0Mne4YhqxJ167HDcKu0=;
 fh=zocfm4Q67c+PPBh18JCV//nJxkrR289QsvMCYROMCVE=;
 b=GNjf0fwDvRpFSaTr9ZXCT6CB2GWGG0hgkPWmG/ZQVnzvHl8aKm2V7vleUVJP9AAzKq
 /N+p7xExYgWAfbO/kA8e2nPRDx81WSyh6SibsP4QrJ+AcE40YE8rMRn7JIejtVlAFfG0
 TAf3bFZQEotKw0kZlvi41SmX8Yx/D5pkVDpwdgs9yUJrqQrjrb9Engy7xQ1N6BHLa3Vm
 pqWsaokPAq+CqtOYKreVlf/XZhxLqhuiANoK79Xm18OEOMoc4q0T15EGExUUp2yWTpPL
 BSbBuqiSurw3wilvu6dRVOedfY04FcbrR5TrnbW/fgnNKxBq/9gESQ508QEW2KiKat7v
 yzqA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773155482; x=1773760282; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VWC4XeaSStWmWq9uFVpFYeeb0Mne4YhqxJ167HDcKu0=;
 b=e3ResSzX7RW798hz8fxGbioBUrnSfTJW1lSSSryNkiclVQxwSok3RDTTnodDDN0RW+
 4pzq7CTl4YHBaiBfkbvTJU9tUrMgGZ9qGx8ki4w9V7cCnSKpMLDmnK6d8EjDL7EckRbc
 oZ5qSMTwu2mAKe6Mdz+/76NPI1Yi+wa1lJlsw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773155482; x=1773760282;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VWC4XeaSStWmWq9uFVpFYeeb0Mne4YhqxJ167HDcKu0=;
 b=sHLqTD5dr+zthlj6uICzRaUvr8qMhsh+Ig2AMyRzyQww8jb3KzBiXwsPDyPwPfYXyV
 NZlO8aZPcp8J1BrdqmSHX64CP9FdkaLtZ0iyhlfjKP1EUs+s1P3Nf2uL2NEnl6pPqXeG
 O54dAegsFvK+D83xWjb8zKGKj1KQT3hltzbZw9OYT9d0HPrHbpgpttJ4G1NCPDrs2UrT
 ODu1GSn0V27czHlW4ruqGAEt6FSEzRlgMwmHoqrS/dXWE8EIUeSm+Um4wfHTTh/U7h3W
 Atu304Tzjw7r6KYXyCfKqSEhUuOjqAoGA0MQHYbu5XYo+d1/TiR/lCklN5liX7rjJwO3
 G4og==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvhpLKcrlvPv1gwN4aNmtLBoMflf27PEtZhs/DgUkOt253tpVD5w3gorA/KYSKiUd8qDc=@dpdk.org
X-Gm-Message-State: AOJu0YznjVzpYDuSuPnM1sCjBvaBM46OTRZyKDKVKEsNwSoY7umgFvOY
 VsCRrZJkYHHQMeOPptBsC+5Vz4un4a0qoFR3dn0BI+V8tmQzpED58xX/3kJ+7iv5+Lis1ul2Q/D
 9QKmP5d82F3E6Qs/eHZVMlcudiyocw1K2x4ECl5tiKA==
X-Gm-Gg: ATEYQzw8K+lLr0LXVqgMvhc4mWMpKwz21zK93kdkrt2wZvWWdjglAGCocsRuxQ2cVlM
 Ut5LbX6crPSdR9zknPyUFOYGt15mN7Y/OI3stOxKlYloq7Upudnh3SFWPTQYQFkx3HVkV/Hvy4a
 lCU5giS717odTxP0i2AUU5BnXqtNH0xLrJTKq5jZ5fmRBQTWMNAe8MXyyWaMbXNW6C/aXtJAUea
 dmLU0jSa0+Gtu+AdI1AQ8AV5469BUM1UT+I8Q0wWkDL56oYz2A/svEdAkMlfF/VNkp2QAu24lS3
 uug1H4vsJuwlZa0HXDd6bLkuL72TeoVz946KKHE4wPnvub2Qq3Vm9KSRXxBuEkOSm09E+vtM
X-Received: by 2002:a05:7022:31a:b0:119:e56b:958a with SMTP id
 a92af1059eb24-128c2db2e1dmr6321797c88.15.1773155482144; Tue, 10 Mar 2026
 08:11:22 -0700 (PDT)
MIME-Version: 1.0
References: <20251121195511.322005-1-abailey@iol.unh.edu>
 <20251217165716.705128-1-abailey@iol.unh.edu>
 <CAJvnSUBd-Ywb5feeqQTDvVdsB_=4-BgdM5YkdGhOCTAJ2Gi2mA@mail.gmail.com>
 <CAJvnSUALWudn+Kqv3wptWAwuiws9H+P2_VYu8=q0P4V4_yoFJQ@mail.gmail.com>
In-Reply-To: <CAJvnSUALWudn+Kqv3wptWAwuiws9H+P2_VYu8=q0P4V4_yoFJQ@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 10 Mar 2026 11:08:20 -0400
X-Gm-Features: AaiRm502AvhgHa1Rk22ZgNqtprqnPNuMWgadIlEltDZRR4ivucVCHU_d61pD5tY
Message-ID: <CAJvnSUBnPcGhCScTwUiJ+MMt4tBNFFo5oBi_XW3mqm5vGqCk_g@mail.gmail.com>
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

Pardon me, I should have said it's "definitely" not sniffer related -
of course the issue is trying to set a port setting in testpmd for a
port that doesn't exist. So again let's decorate this testcase with 2
link OR rewrite it so that when topology has 1 link, the tx port
setting is set on port 0, not port 1.

On Tue, Mar 10, 2026 at 11:06=E2=80=AFAM Patrick Robb <probb@iol.unh.edu> w=
rote:
>
> One more issue (that is probably not sniffer related) is that when
> changing to 1 link, vlan_header_insertion testcase has an ERROR result
> with: "Testpmd failed to set vlan insertion tag 51 on port 1." This
> makes sense because usage of port 1 is hardcoded into the testcast -
> we need to decorate this wil requires 2 links.
>
>     @func_test
>     def vlan_header_insertion(self) -> None:
>         """Ensure that VLAN packet is received with the correct
> inserted VLAN tag.
>
>         Steps:
>             * Start testpmd.
>             * Set forwarding mode to MAC.
>             * Disable promiscuous mode.
>             * Enable Tx VLAN and set the VLAN tag.
>             * Send and capture VLAN packets.
>
>         Verify:
>             * VLAN packets are received with the correct inserted VLAN ta=
g.
>         """
>         with TestPmd() as testpmd:
>             testpmd.set_forward_mode(SimpleForwardingModes.mac)
>             testpmd.set_promisc(port=3D0, enable=3DFalse)
>             testpmd.stop_all_ports()
>             testpmd.tx_vlan_set(port=3D1, enable=3DTrue, vlan=3D51)
>             testpmd.start_all_ports()
>             testpmd.start()
>             self._send_packet_and_verify_insertion(expected_id=3D51)
>
> On Tue, Mar 10, 2026 at 10:53=E2=80=AFAM Patrick Robb <probb@iol.unh.edu>=
 wrote:
> >
> > The implementation of the patch looks good to me, but I think the
> > testsuites being reduced from 2 links to 1 link might be an incorrect
> > set.
> >
> > For instance, I just did a testrun on cx7 comparing for-main to
> > for-main + this series.
> >
> > This series introduces failures for:
> > port control: start_ports testcase
> > vlan: vlan_no_receipt testcase
> > vlan: vlan_receipt_stripping testcase
> >
> > In terms of why these fails are happening... in principle the
> > functions flexed by these testcases should be fine to test with 1
> > link. My guess is we are uncovering an issue with the scapy sniffer
> > when running a 1 link test. The port_control testcase fails because it
> > expects 100 packets and sniffs 200. Perhaps this is because it is
> > sniffing both tx and rx packets on the TG port 0. We have code to
> > prevent this from the most recent implementation of the sniffer class
> > but maybe it has a gap.
