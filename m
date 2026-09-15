Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4C2C88E72
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Sep 2026 00:12:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1AF1B40290;
	Tue, 15 Sep 2026 02:12:30 +0200 (CEST)
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by mails.dpdk.org (Postfix) with ESMTP id E03D340278
 for <dev@dpdk.org>; Tue, 15 Sep 2026 02:12:27 +0200 (CEST)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2d6e954afbdso30635885ad.2
 for <dev@dpdk.org>; Mon, 14 Sep 2026 17:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789431146;
 x=1790035946; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:to:from:date:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/T4aXB+H74vJpZBnfJPTHs7Me3us7l7W1FqD6vltGis=;
 b=Pjp8Sr5hi0t6/Fq6ECg+6CCSQ7hAtmO0pCgKwMhnDCetoJX0dRgWC6KFB6ZqqV1Zoc
 la/nSTSxVPllV83RfnskzxnZnlqvOYAuvJtrPx+9Lzehfg+CdWOXTdOlUgMf4K461Alq
 9yPIynrcN4LHKw4W9XyVr+DRiTz0Qdhx3O3zMFlLPmDo4ZwF4QhiVwbGvmgmfBzMvEYa
 2jmsF0+FbaJCX//fEUOz36g7voKdR9XNN/w+F3CsdAX6lCbPJJsaqboRo5+26snnbTBt
 BN876RhTOxRSjWSu4G33okaPUASzLJP1JBASPRyd6o5D7VUgCRnThYubEF/Dspp3SECP
 X41A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789431146; x=1790035946;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/T4aXB+H74vJpZBnfJPTHs7Me3us7l7W1FqD6vltGis=;
 b=ead+86zAU+pPGH7RM5pwpDS42iTLfE/Fvzuf7Fvxcc4EuwLTM0siERuRRHDlWSKFbG
 YEbpJIhNx/AlcCoVzvXndvoNjQ0SrACZB3e9x53+g/KTTfVXE4M54Ff+SL/9ZcHw2CTf
 u8JFFWRGurbT5LV+pEXJ7LLsZKqd7+WQLT6ZUWPqmpudlH4ygZ5hgqVVz0RBrFbT9wBC
 HLjTicbQPSGqFIemsJoFO4YrSZz2HFgC/z7120W2VKnIeala/X65HwaPF6rjS9Warp3U
 ZGeRk8cF/FU+33LCBQpo0aAE93iPCLlIIJYnEQXL9c3+AdPxZc8dQvBSFif5m+lXxZGo
 Rphw==
X-Gm-Message-State: AFuF++mR+gymps1I+uyLtgaeTAUokofvuSGWLAfy+M7kdQiihOhA2teP
 X7+KPUFhDs84ssK9cSERVl/aCwM3eDO9s8x+gPNIxBkflNUmgaAit4lYUY7maF4oBVd4lOhVVcw
 +k069S1s=
X-Gm-Gg: AYBFou0gu8E8by4JgTWj7IvJIz+MNVrwpX1nHdOivlBmHZEcEd0J/gbduT6mXBzO2NE
 xpKqdCitt3yC0Q/RGzHA0FlTe+XMLEYLk6p4FAhzn5agmXUWumwXJSkXMq/eR7Z48H7DMg2GAZL
 l84hoKH+4iHcr5NdcBq6nIyOR02etsbVzLNozG5Fcxl3GgNqcll6CB5aEL9StMD5U/MqF3hGYbn
 fzAIvtK/hFnq4prjK2boPBmEFDP//GiJoqBbPSFWPhQc/Gkmymi0D63mc2UhSGXySTgtnJlopDp
 K5fgmRiNPpEzzcL3LVoVKKSbaoro10ll8K8nKNPnVQA299ZxfexaZsYfKaxcJV+9BarCJz7PkRG
 u27lyFn5uU374yF0IZNxyYyHiX2J3t3b0Zdu5GXf11fzMADyAFJVHKr+6XNNhpibX9eu5IF80pD
 f76laoF0VAFQSA/q2kiwmlyxZusXfey4ZQHqDf1UiiH49PI2PxnkyGgHwOtEZPcf0+H6+bTmKds
 lJb4ru8XplvfjEXPWAfpndpY1nhiYU3kNNPDUNO
X-Received: by 2002:a17:902:db04:b0:2dd:3ddf:b87a with SMTP id
 d9443c01a7336-2dd6c486954mr93291725ad.0.1789431146504; 
 Mon, 14 Sep 2026 17:12:26 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd2cca264fsm57799395ad.11.2026.09.14.17.12.24
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 17:12:25 -0700 (PDT)
Date: Mon, 14 Sep 2026 17:12:09 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Subject: Re: [PATCH 0/7] fix XXX_DEBUG warnings
Message-ID: <20260914141308.4b774381@phoenix.local>
In-Reply-To: <20260904191652.2399074-1-stephen@networkplumber.org>
References: <20260904191652.2399074-1-stephen@networkplumber.org>
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

On Fri,  4 Sep 2026 12:12:35 -0700
Stephen Hemminger <stephen@networkplumber.org> wrote:

> I recently modified my build test to automatically enable all
> DEBUG flags. This is because developers often add debug code,
> forget about it, and it bit rots.
> 
> This patch series fixes all the places where #ifdef XXX_DEBUG
> code was present but would not build without warnings.


Applied to next-net.
Now all of next-net builds clean with this series.
