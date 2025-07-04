Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182F9C83F03
	for <dpdk-dev@archiver.kernel.org>; Fri,  4 Jul 2025 19:51:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D890A4028E;
	Fri,  4 Jul 2025 21:51:28 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id D32E64028B
 for <dev@dpdk.org>; Fri,  4 Jul 2025 21:51:27 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-b39011e5f8eso62525a12.0
 for <dev@dpdk.org>; Fri, 04 Jul 2025 12:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1751658687; x=1752263487; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mYNNOOtXPGigdp58usrVhDUHb3rOImrhh/BVOE38DdA=;
 b=Dox40JXQ5kgZZs0OLO1fVPBE2Piz/uByzy3j9uAbccTCclwocArgGusd7/dqDJvb3B
 CMQS2CvPuTD6jJsSoAcLHZkaJn3Bk+nsBHRnIjFpf2oeAos7GNjhVG04MK2VoEoDiYj1
 FZxbfrwmQkogZO05g3NfjrHE5B9gBtMM98Ok4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751658687; x=1752263487;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mYNNOOtXPGigdp58usrVhDUHb3rOImrhh/BVOE38DdA=;
 b=erWgQCtK1XbbR90BKgtHAYZdkjUP5v/YoRTX6j07EUCzNMPU5ZjOdZmAXaGUrY3aOt
 aRD5EZkdKvaG55BsuO9pBdcGfOGkMLNpjllQKyUd3eo48p7rJHu4zgPKrcL9414IMtbH
 FZuI7069uE3WXjUxpJQQcltsYKC/V8b6ydCRIVYurkJ/2bzFOH9XkaTCaBJ/Zz9+a3jn
 q7DFtYhjvptnRM3PDYsj/I7W4Oii7I0cx0B8XBa8eVi+t/OU/S2CtCgz3lcIHByp1mtM
 hFDKrbFsUjErONRAzNHp163HTLRig3zsDTu9HWs7KT5gNM49ULbvY44nShyNFskRkM9V
 LzHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUr08SCTJmik/Ly00nRQt1fC8jb1fu8xjL78p3H7UK6wbympfxYCR8Zb8ncAwyZN/mjMwA=@dpdk.org
X-Gm-Message-State: AOJu0Yx5mVPHZpa5thPvX7ce3l4to3U3X747JlchB63il/jZ9uYocZFG
 ADcDsaN5J+GOYxGcHilt4tfNrbI9e/ex5aNc4aJHbmniYCV4lhcnd4FF/YoBu1wYxC73l7l65ah
 WbFH3PNYi/SWzrmCbwuFt3t3Pf1sGltTNbFiCaZ8GDQ==
X-Gm-Gg: ASbGncsYziGy7OzVSgOzrbOXHrC0ut0aG2WwmnvEuBPqcKalVEKB55syiSbhnQUX5RS
 kyIBA+jybzKow7CeFmQLX16RL3L/+4qTKCXiJkVDGu3KdIWcee2ArkYWRf7ARxCwOCMN3mxQxGS
 tD/+l44F8Sd2cJ5zCyC1eFuw6xY0ox/FX/eElRkqPH3jHwOgJgI04t8kyMfs7DFeiDrdimumYes
 LM=
X-Google-Smtp-Source: AGHT+IEQVw1+F3tvCjvb4TYjyKd+JfucektE0RGpuAnN2D0EwYr+bASXniZeUy5uX7eaxY0bLbPtSWTUU44TmsKJprs=
X-Received: by 2002:a17:90b:50c7:b0:311:a561:86f3 with SMTP id
 98e67ed59e1d1-31aadcad204mr4611679a91.6.1751658686917; Fri, 04 Jul 2025
 12:51:26 -0700 (PDT)
MIME-Version: 1.0
References: <20250626152755.197560-3-dmarx@iol.unh.edu>
 <20250702162331.352313-1-dmarx@iol.unh.edu>
 <CAJvnSUAO7iBHp9Fm7WiCrCfou3JByrYsL8ZyufcO9VZh-yNM1w@mail.gmail.com>
 <CAJvnSUBxJofw934abTkeBX8ConPxUPj=XKSv3u8EuxFBRiZfAg@mail.gmail.com>
In-Reply-To: <CAJvnSUBxJofw934abTkeBX8ConPxUPj=XKSv3u8EuxFBRiZfAg@mail.gmail.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Fri, 4 Jul 2025 15:45:48 -0400
X-Gm-Features: Ac12FXxMhP1UaEMiZE7Cg4PjBB7HjL2afqSQZY0UFSvhSX1tk_nZAvqlApkupdI
Message-ID: <CAJvnSUA1PM01oHvsRRt7mru5Tuj-rjMh+hOjR3zG9g1WkD-wrw@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dts: add virtual functions to framework
To: Dean Marx <dmarx@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000cd435306391fd18e"
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

--000000000000cd435306391fd18e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Series applied to next-dts, thanks.

On Fri, Jul 4, 2025 at 12:25=E2=80=AFAM Patrick Robb <probb@iol.unh.edu> wr=
ote:

> And FYI VF results for ConnectX-5 virtual functions for a testrun I just
> ran
>
> test_suites: ERROR
>   vlan: PASS
>     test_vlan_header_insertion: PASS
>     test_vlan_no_receipt: PASS
>     test_vlan_receipt_no_stripping: PASS
>     test_vlan_receipt_stripping: PASS
>   rte_flow: FAIL
>     test_drop_action_ETH: PASS
>     test_drop_action_IP: PASS
>     test_drop_action_L4: PASS
>     test_drop_action_VLAN: PASS
>     test_egress_rules: SKIP
>       reason: flow rule failed validation.
>     test_jump_action: FAIL
>       reason: Failed flow creation
>     test_modify_actions: FAIL
>       reason: Failed flow creation
>     test_priority_attribute: PASS
>     test_queue_action_ETH: FAIL
>       reason: Expected packet was not received on queue 2
>     test_queue_action_IP: PASS
>     test_queue_action_L4: SKIP
>       reason: Required capability '{NicCapability.PHYSICAL_FUNCTION}' not
> found.
>     test_queue_action_VLAN: PASS
>   port_restart_config_persistency: ERROR
>     flow_ctrl_port_configuration_persistence: ERROR
>       reason: Testpmd failed to set the rx on tx off 0 0 0 0
> mac_ctrl_frame_fwd off autoneg off in port 0.
>     port_configuration_persistence: PASS
>

--000000000000cd435306391fd18e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Series applied to next-dts, thanks.</div><br><div class=3D=
"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">O=
n Fri, Jul 4, 2025 at 12:25=E2=80=AFAM Patrick Robb &lt;<a href=3D"mailto:p=
robb@iol.unh.edu">probb@iol.unh.edu</a>&gt; wrote:<br></div><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr">And FYI VF results for =
ConnectX-5 virtual functions for a testrun I just ran<div><br></div>test_su=
ites: ERROR<br>=C2=A0 vlan: PASS<br>=C2=A0 =C2=A0 test_vlan_header_insertio=
n: PASS<br>=C2=A0 =C2=A0 test_vlan_no_receipt: PASS<br>=C2=A0 =C2=A0 test_v=
lan_receipt_no_stripping: PASS<br>=C2=A0 =C2=A0 test_vlan_receipt_stripping=
: PASS<br>=C2=A0 rte_flow: FAIL<br>=C2=A0 =C2=A0 test_drop_action_ETH: PASS=
<br>=C2=A0 =C2=A0 test_drop_action_IP: PASS<br>=C2=A0 =C2=A0 test_drop_acti=
on_L4: PASS<br>=C2=A0 =C2=A0 test_drop_action_VLAN: PASS<br>=C2=A0 =C2=A0 t=
est_egress_rules: SKIP<br>=C2=A0 =C2=A0 =C2=A0 reason: flow rule failed val=
idation.<br>=C2=A0 =C2=A0 test_jump_action: FAIL<br>=C2=A0 =C2=A0 =C2=A0 re=
ason: Failed flow creation<br>=C2=A0 =C2=A0 test_modify_actions: FAIL<br>=
=C2=A0 =C2=A0 =C2=A0 reason: Failed flow creation<br>=C2=A0 =C2=A0 test_pri=
ority_attribute: PASS<br>=C2=A0 =C2=A0 test_queue_action_ETH: FAIL<br>=C2=
=A0 =C2=A0 =C2=A0 reason: Expected packet was not received on queue 2<br>=
=C2=A0 =C2=A0 test_queue_action_IP: PASS<br>=C2=A0 =C2=A0 test_queue_action=
_L4: SKIP<br>=C2=A0 =C2=A0 =C2=A0 reason: Required capability &#39;{NicCapa=
bility.PHYSICAL_FUNCTION}&#39; not found.<br>=C2=A0 =C2=A0 test_queue_actio=
n_VLAN: PASS<br>=C2=A0 port_restart_config_persistency: ERROR<br>=C2=A0 =C2=
=A0 flow_ctrl_port_configuration_persistence: ERROR<br>=C2=A0 =C2=A0 =C2=A0=
 reason: Testpmd failed to set the rx on tx off 0 0 0 0 mac_ctrl_frame_fwd =
off autoneg off in port 0.<br><div>=C2=A0 =C2=A0 port_configuration_persist=
ence: PASS=C2=A0</div></div>
</blockquote></div>

--000000000000cd435306391fd18e--
