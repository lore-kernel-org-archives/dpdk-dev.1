Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC74C5AE59
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 15:20:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDE1740E35;
	Tue,  3 Jun 2025 17:20:27 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 14E3D402C8
 for <dev@dpdk.org>; Tue,  3 Jun 2025 17:20:27 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3122a63201bso4405000a91.0
 for <dev@dpdk.org>; Tue, 03 Jun 2025 08:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1748964026; x=1749568826; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=SB2kvjMXFzgkhbg1XBQBSPOiim7LdqI6jCq9cfScv1Y=;
 b=XmLSkMdxDxjRHc8VJyWvEIai4kwiKmi3RmAIX7pf4ye5+GLqYHlJMcfk8B45MECD1E
 UAXr4rv6kG2FZ2IZVF1T8+PNSCLhNQG1h7I92330wbNiG3R7H3eI4YuBBAup3U2QY2Mh
 o8301ucyV5Yy7SnWRyc86OzBR3oVvObU3zgmE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748964026; x=1749568826;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SB2kvjMXFzgkhbg1XBQBSPOiim7LdqI6jCq9cfScv1Y=;
 b=WfwbkNzb+HuZl7Eq9Z5YHoz5pAaoXYzeVhmv894UWiyqaORjdnWMCWiTSsuyqoX3Md
 eASNe88c5O4Ya0dA6ytBLaz7PLkwuvODf3RphsZzuh6csMIf2R6++Uz1LevCY59gCHGD
 GKD+lB427oqxMQMcmUdKuUVg3Z//Kl/re2/JSvc3Lv2D4+d4bE5KUaeXTwdiV6ivX64u
 wl7WXoNpOjmVCn/hCDwU/HTo6biZS7t0Fy4MdaGIBSMBYHuwpppMnQHToZaWs5SjeVlb
 HMflDJHpHF0pUm8//eLjfXomDg2NuACskOt9LHr9z6VCJPjZDmVybtL+b6soX4Egxt5c
 0Uxw==
X-Gm-Message-State: AOJu0YyY7QRBssFsy6XcVn3kXI4HszqcMi4YAxKbbUBSfCdtblOZFa10
 gza92A6HkS+bf6GUI8mNVjfWs5omzhPH2cNnQY9bsjz7ETriDkAIl5d+NNaTMugNhxIBXRWlBEW
 63NWUE0HB4Af1M7F9rhpF9xNYyaLgNn/2mZoc6BMsVxDCfFhDkyZSI8g=
X-Gm-Gg: ASbGnct8IguxhhuqBEr6p3P8IecY2xCBIg2wn1f88OgPw0xakiWsrwgXDuN/dyMfvXG
 AV9QGtwX3mdfbkRrCI1xb597nLulieZOmrY1b28OU3bDaC9wBrmiPxFIA93bfT1nFggNKFTrcKb
 qFjt7pe/rEWB6GUh95TWqJLjgDtlGjCaOj26fLSdt06Un7
X-Google-Smtp-Source: AGHT+IF4Fcc8tb7CwiaKyMYJfctflRoD+BVySH/mK43kQp9Vrn5ZCginip1UIw87yMFyLrL5yrS5HthyV9wq+LiJjmk=
X-Received: by 2002:a17:90b:1810:b0:311:c1ec:7d0a with SMTP id
 98e67ed59e1d1-3127c72e97bmr16801539a91.25.1748964025386; Tue, 03 Jun 2025
 08:20:25 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Tue, 3 Jun 2025 11:15:24 -0400
X-Gm-Features: AX0GCFu1ye9iHWeKj9816JfQRMKeswHV0oppvmtHN7i1PS4hjJS50DfgTOU1gDM
Message-ID: <CAJvnSUCFRccZaKrmiTorg+i_45cmjZ0mq-S9kMOt-SHHaKVC9g@mail.gmail.com>
Subject: Cancelled - June 5 DTS Meeting
To: dev <dev@dpdk.org>
Cc: Paul Szczepanek <Paul.Szczepanek@arm.com>,
 Luca Vizzarro <Luca.Vizzarro@arm.com>, 
 Manit Mahajan <mmahajan@iol.unh.edu>,
 "nprattedev@gmail.com" <nprattedev@gmail.com>, 
 Dean Marx <dmarx@iol.unh.edu>, mamcgove@microsoft.com, ci@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000075761f0636ac6b88"
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

--00000000000075761f0636ac6b88
Content-Type: text/plain; charset="UTF-8"

Hi DTS contributors,

I am unable to host the meeting this Thursday. And, like we discussed at
the previous meeting, a couple other regular attendees also have conflicts
this week. I have discussed with Paul and we're going to cancel this
meeting and handle any conversations over email this week.

A couple things to note:

1. Paul is merging some patches to next-dts today/tomorrow.
2. We picked up a couple warnings from check-git-log.sh which we need to
git amend some of the commit messages and force push to next-dts, also
within the next couple of days. Can discuss over the mailing list.

Thanks.

--00000000000075761f0636ac6b88
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi DTS contributors,</div><div><br></div><div>I am un=
able to host the meeting this Thursday. And, like we discussed at the previ=
ous meeting, a couple other regular attendees also have conflicts this week=
. I have discussed with Paul and we&#39;re going to cancel this meeting and=
 handle any conversations=C2=A0over email this week.</div><div><br></div><d=
iv>A couple things to note:</div><div><br></div><div>1. Paul is merging som=
e patches to next-dts today/tomorrow.</div><div>2. We picked up a couple wa=
rnings from check-git-log.sh which we need to git amend some of the commit =
messages and force push to next-dts, also within the next couple of days. C=
an discuss over the mailing list.=C2=A0</div><div><br></div><div>Thanks.</d=
iv><div><br></div></div>

--00000000000075761f0636ac6b88--
