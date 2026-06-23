Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7135CD98F2
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 17:32:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD5EC402B0;
	Tue, 23 Jun 2026 19:32:08 +0200 (CEST)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173]) by mails.dpdk.org (Postfix) with ESMTP id 284F6402A2
 for <dev@dpdk.org>; Tue, 23 Jun 2026 19:32:07 +0200 (CEST)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-30c03b09e02so101320eec.1
 for <dev@dpdk.org>; Tue, 23 Jun 2026 10:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782235926;
 x=1782840726; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YtLRGVruyDAOGJyVTPftcOuy/Hq0DVmYofoPId5ZSE0=;
 b=M2H07GaUXi3BKeXYE97SC+a7Wfz/s9zjO+8hUbsCqZIN3ogVA6H7fWoX9ORCDOEiKc
 NEQxKF5K5i/rNt2MAp/tra6ip/q0Qks8xQbxK76uSPo4D+Bs9zTw6GTQeHqOKtiTV1PP
 O3yYgArbHfX5q8Q4Vi9LkplM2chdGkh6KPOzfOnjJZ7Dkq2eSD/i97Tj6uVCM1MODxXj
 wc1UNK9uzgnZtFSBTFK+irDC0KatHSi2rEdXVqoFZhfkVYftj/VNGCuaG14Je2IjX6/f
 /oBxP3OI0hIb5Nja6TYn+Yip/zFDZ82diDLlCzZ2P+kpZuM5FyG3QBkcZljkL0QSwyxW
 bzkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782235926; x=1782840726;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YtLRGVruyDAOGJyVTPftcOuy/Hq0DVmYofoPId5ZSE0=;
 b=NXzUfJl8MmZF9+tMbwVPZAP0eFskhI8L3FdvM3/HA7Qu3lXoKoHxGkM5m+LwEied6n
 94bJi7FXPTtckH9Z+PMHT4gpjeI4wdPliapRIAhlGPMNWY3GkP2LLXt/kliGPm3gFPmd
 1yxfXMTdAwj7oB0d9AIgPcB93MAAQnNj1XWL+nmFBBv1iGkuMb9wRt2dkXQMfHgTG7gj
 hyr60USzKK6245sUA4Y+63qfTreRgLxGXezsdPHcvWfx15wYDJI4KoqBhrCTJ68mM8c+
 dxxyKOZeXW4TwHOcYe4AAUecNKT1tyvPneVoUMUH/n4ifEwt2vd8rsIDd1FdcgMMkJCa
 7gog==
X-Gm-Message-State: AOJu0Yw+ES3qMElmtPJVwbtbWBF6SCKjWbpo0dsLFSzkWsfgxIG5bWCU
 UXoKmL4We+Rrrwi4WoJfhoAe5J/lJ4SKsdBlTM3jGGjkjlx8rqxfNLq/ntEtMNWRB4c=
X-Gm-Gg: AfdE7cnHrMuZ8OPBkuJ+pR183sto7ZPGrzgySRsPIMA0EZN+5m0MtXwRB814OvJGX2d
 qUimiuVjRVCzqi+TIURklf/EXyCOHgYkhX0zHvcJeSWdtdPT6iRKyFaBRFip3DYNEudxEbCYOiR
 UQnK+Wu5tPhUEnaRTnaZv7ehwfrs9qoVQCJoje/la5HEdc9nwQKtxNctFFbmS8qyuh4qUVrsrdd
 wIRiAOfGkmPsczggJNwLRIPdM04BObT0cAerFKCdYlljI3b8FnoOcVeXzszH0RtMnRIrU44h8F6
 ynzPwnaw8sTZZOdYPLdEy0MRZ7FVOs7GyjxM4tRN5G3N14KmYE8j2iAQ2AuSXy/0xOXZAjzl19u
 /Xw0AMunRCVTK2Y3MuXFf0f56Ps0X6jOp2lxSJxMH192G1PgaXGhJCwrZvyc6p5lY79HVm2xVQo
 vQmtmmiWM+QV60h8EzpSj5Ye0kIF0MhwMyNoRAC4+OBkBq0BIALOHDhA==
X-Received: by 2002:a05:7301:1f04:b0:304:d82f:be10 with SMTP id
 5a478bee46e88-30c58a2f866mr3371512eec.11.1782235925819; 
 Tue, 23 Jun 2026 10:32:05 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1ba1c376sm19276692eec.3.2026.06.23.10.32.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2026 10:32:05 -0700 (PDT)
Date: Tue, 23 Jun 2026 10:32:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Gagandeep Singh <G.Singh@nxp.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: Re: [PATCH v3 0/9] ENETC driver related changes series
Message-ID: <20260623103203.196ee5ef@phoenix.local>
In-Reply-To: <AMBPR04MB1228197B164EA32B50E63FC03E1EE2@AMBPR04MB12281.eurprd04.prod.outlook.com>
References: <20260622113517.1616028-1-g.singh@nxp.com>
 <20260623060004.2187716-1-g.singh@nxp.com>
 <20260623084657.0923ab04@phoenix.local>
 <AMBPR04MB1228197B164EA32B50E63FC03E1EE2@AMBPR04MB12281.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Tue, 23 Jun 2026 17:21:59 +0000
Gagandeep Singh <G.Singh@nxp.com> wrote:

> It seems that AI reviewed the V2 series instead of the V3 series. I have =
manually verified that the first two issues are fixed in the V3 series. For=
 the last issue, I will submit a separate patch as a new feature, introduci=
ng KEEP_CRC for the enetc4 driver. Additionally, AI has acknowledged that t=
here will be no functional issue as of now, since crc_len will be only 0.


It was my bad, was looking earlier in that chat.
Looks clean will apply

For V3:

v3 re-review. I diffed every patch against v2; the only substantive code ch=
ange is in 7/9, and the rest of the delta is documentation.

Both v2 blockers are resolved:

The kvlist leak in enetc4_vf_dev_init() (was Error) is fixed =E2=80=94 rte_=
kvargs_free(kvlist) now precedes both the invalid-timeout and invalid-delay=
 return -1 paths.

The missing devargs documentation (was Warning) is now in doc/guides/nics/e=
netc4.rst: a new "Driver Arguments (devargs)" section split into VF-specifi=
c (enetc4_vsi_disable, enetc4_vsi_timeout, enetc4_vsi_delay) and PF/Common =
(enetc4_txq_prior, nc) subsections, each with a usage example. Section unde=
rlines are the correct length (19/19 and 17/17), so it builds clean under -=
W; defaults and applicability match the code.

No new issues introduced =E2=80=94 patches 1=E2=80=936 and 8 are byte-ident=
ical to v2 apart from the doc hunks, and patch 9's only delta is the nc doc=
 plus line-number offsets shifted by patch 7's two added lines.

For the record, the one item carried over from v2 is unchanged and remains =
non-blocking: in the RX reassembly paths, first_seg->pkt_len -=3D crc_len a=
t frame-last doesn't adjust the final segment's data_len, so pkt_len !=3D s=
um(data_len) if crc_len !=3D 0. This stays latent because enetc4 doesn't ad=
vertise RTE_ETH_RX_OFFLOAD_KEEP_CRC (crc_len is always 0). Worth a guard on=
ly if KEEP_CRC is ever added; not a reason to hold the series.

No open errors, no open warnings.
