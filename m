Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C0BC79F99
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Sep 2026 21:10:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C824240655;
	Mon,  7 Sep 2026 23:10:52 +0200 (CEST)
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by mails.dpdk.org (Postfix) with ESMTP id 48782402E8
 for <dev@dpdk.org>; Mon,  7 Sep 2026 23:10:51 +0200 (CEST)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-862815e2683so2345584b3a.2
 for <dev@dpdk.org>; Mon, 07 Sep 2026 14:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788815450;
 x=1789420250; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=+35uwnctGOZptunYacPQDr+Af0vNB2Q9qb9NtA5KauA=;
 b=DlnhvakfkEH900+s0NX4p1l4w1r56LIDdxmI/lIoXBMjkX6WEhVyEFrCtnabTxjV/C
 nR03OMo6nKHHl9ZI2igPY68FrnnJRZ+S26ZAoOe90c5vdysVceu6oeOYydBfTlc2K8gL
 xs+w8r0zd5wDEcP8W1y65KV+otyp6qb88IMxPzJpUiuwdUUuDtehUtirVNmwgOMlU0gF
 iqqcVtkdD6J4E+qCsP7/JNnliGkVP5IIbjdZa75Lv3uMm5i0YSx6qieX3C6/3WykgGL1
 RXvWZkdjgGGZUvy/ubD2kG8jAKnyAYq59ulCpvQ4j4em/ct75Q1bzvOZnJkoiR897A47
 2ECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788815450; x=1789420250;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=+35uwnctGOZptunYacPQDr+Af0vNB2Q9qb9NtA5KauA=;
 b=S97gmYUytuh8f3zli9tAC4B94BdcM4f4ByB/GNvgGRztHFdwwrcuaqSH4OV1/WctXX
 TDGXMsP8wKqxLWVMUzjL7/7III3UhhftyRGt3OhPc8CXCBtox7CdJEfMCClRigYtMo+/
 NkXLY1fBBvDTAR4B0q65laZy8TmHKFrbxSFHBKHmKTvL/AoL54pBJzR9gKAqA7gydjAA
 0Z38AazmTxTKJiX04a+RGwHlc35yqNbP08hUXzlcaCyoXmQNdATtMuUQV5icDkzyBGD/
 o71nLQi3JWuZu5oZmLjceOPvjDDLbf/jpulUfbjOleyA110fZiKQCDcRLbMyWEbHSWft
 7sGQ==
X-Gm-Message-State: AFuF++n4nklutTGajphbScKhdBkiZBanl+vbnQ5PEf/XLXY1CPgtkrok
 8XRM4+4E/7ltmjPbyb8anQtqFxihJ9Vad/PC0GkmkDr6Fb5v5QUAlIoVJTA4hzy8e2k=
X-Gm-Gg: AYBFou2nNVgrZmMwfqCR7agcyIzlBkfFgbfklXskJV1tdxlCJB/sefWi4+SpYVJgI8C
 WfQipArXP69STmbsmUQSdt/3UqiimMOApc18daZGR861za9IZNQOtB29jnzBQJ6faee6WXByUOP
 f1Nt8gNcda19R0rD0cxB3sFu+dI80KDt8qESd1m+ieuDwpnky0N0w4KOpAd7K22A24dPPrUEZO/
 slqY6OOWSQssyAgCiBr2BRBrUWxhEz7BtCB0HZk3mrHmxqJQQ6Z0oGAJ+EPpO306whSXgw4ZLPt
 5XFyEY77Lat/M0AhqhbFYIAGu4UpCEyJrpbxENAadeTZBGB7i9+OHuUGM0d49gIADWOEggyGUmt
 j9MbuNLEA+BqqCF+QoRy1ul0Dq9QCowT94Jk7AA6pos6/AguRTMlSgTRz099Jm0i4OGZ8euRER5
 QR1ymmaoOtiIea3AXgM0U+XZUroc+v8Pr8diMgHJ/HFdjwUfL7O0SeI0Lh2Ys14Rig7JFzjd6Hi
 0m7fXwyskzzKKmUiHI1PkRfXLTspA==
X-Received: by 2002:a05:6a00:4f81:b0:845:3033:6cb7 with SMTP id
 d2e1a72fcca58-86166bc01c9mr32103752b3a.9.1788815450059; 
 Mon, 07 Sep 2026 14:10:50 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-86152045f8bsm4873787b3a.15.2026.09.07.14.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 14:10:49 -0700 (PDT)
Date: Mon, 7 Sep 2026 14:10:42 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Prashant Gupta <prashant.gupta_3@nxp.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH 00/45] net/dpaa2: features and fixes for NXP DPAA2 drivers
Message-ID: <20260907141042.20dcf64f@phoenix.local>
In-Reply-To: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Thu,  3 Sep 2026 19:23:08 +0530
Prashant Gupta <prashant.gupta_3@nxp.com> wrote:

> This series brings the NXP DPAA2 driver stack up to date with the
> functionality carried in the NXP internal tree, together with a number of
> bug fixes. It covers the crypto (dpaa2_sec), net, dma, mempool, event and
> bus/fslmc drivers.


Recommendation, break this up. There are too many errors to allow merging now.
But if you break it up some of the chunks might be ok.
For example: send the bug fixes only as short series.

The problem is you are working away from upstream. That process will
exhaust you because you end up fixing things in multiple places.
For example: patch 24 removes a guard that 57b8ce0 added upstream in July
