Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49314F53D6E
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 16:02:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5ECE44025E;
	Mon, 16 Mar 2026 17:02:08 +0100 (CET)
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179]) by mails.dpdk.org (Postfix) with ESMTP id A9198400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 17:02:07 +0100 (CET)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2ba9c484e5eso5603901eec.1
 for <dev@dpdk.org>; Mon, 16 Mar 2026 09:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773676927;
 x=1774281727; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TCqFpggSGnh+eqeyGbKcKiSt8dIhBuCEcLF7QAU7uwA=;
 b=CV+lGv3iGOJP9EI1Ek6EZ0el+ma9r4foIwARWGOQQCDS5HQ5W6aauAQlm5NnsrQ12q
 4d29lm44faecKlwswRCAPXYu8DcKOaBR0zUhIfOXLgBf8ZyEZRBk4j2MSLQf/Z40IJ/d
 KQOsE0Jr2dba4Y4vZE/jra9fNmMobB9/pRJX53gFclJPHtQjH51gDBskdF+Y9w5zluDe
 6Om5c42tuBR1C6KXoQiJARR9tzMYp5rSLsKjiIY1FvqQNnOvvccLAaAedeBUylyj8DPE
 13eYL1eIxpn36PVckfZXEVs++oOFiPRVEvy9nuX86zlN6yGEPv+S/m0inDFKXFeXeKRM
 OYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773676927; x=1774281727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TCqFpggSGnh+eqeyGbKcKiSt8dIhBuCEcLF7QAU7uwA=;
 b=AiZq6dG37QmSIBieVHJ1g/WLX1p8EpVL5KMFXnM9xpTQj1X9lfQEIlydvcVR4n0/g+
 q4p5mAEHwEWV29aki+ng064my70J7YIqKd6BI4cr3pN/y7j7MlGzd3f4Ev1YrwUVfqij
 cQ02bcnWpMKFIdVF6MHkNJyCqNs+N/b0XxtEU4zsrKRwOFcz2gtoenXmCXGP+XzIXiHW
 okho7DlNkf/5fHWCPbNqOiOqkyyNH8QgBJMGxg3FxaIgneq582Ft1Gad696dR13SVwi/
 A//6alQ1+mHGKwhLvSsZKUaqBwWiVpXxAzK0Rl9O4ODJIJLDERs/ho3VcgdTaT3fcQ9n
 345A==
X-Gm-Message-State: AOJu0YxQtrJ+TXaBTVEPdsVr4o3ja6xDuks7Q2/qBtCd/yS4lKZmsGP0
 WwQtdcDhtiCuAlT7R/cbjnsrgm5LqBatSlphXj2wn0+m+5xDffOPPiuSyauwIG4TKEM=
X-Gm-Gg: ATEYQzy+hHE58GLDncjKxeDfuQQknXzbj6WS/+0o4BjzPRIpLS1keWK1JAoB7xpbwJX
 SsAxlAiYyH7ulky54FOylvTVjwptnY8B08BIxxDKvoJT8i4VCgqL4//3dA5dIagfae1yCdocGQ+
 Y62fqcf9As6DSRWaiTaERE1Wwz6h/XTa+tCOWApe+4PNklklH8joJrOO8Z1vz+kUzPKnrU+Ijka
 AW8iB9IEWNRUwJwplI45Buk+K5RxRKroEsDGshfXkJdSairuArdcEeMv5vrfk9i/EXsjFWtGJ3A
 Ir4062FtI0drYAjX4NutZVDUXLQwUHpg94x12f3rHsLrgIME+3ClPnXzFOdbELRCVRjwrLN1oDX
 49tmqvFpxOHnuY7lCs3OQ9iRM6Y4a0fivpIf6ATo8R2ruZkV2rFYn1Ok1+ydRGEvxuKQbTWT+KK
 KLijV0mRJHv1BvExgSFgnHM+eRjInBTbx2tSFtyawqUxwp4Q==
X-Received: by 2002:a05:7301:d8b:b0:2be:2acf:4098 with SMTP id
 5a478bee46e88-2bea553cf65mr6021774eec.31.1773676926509; 
 Mon, 16 Mar 2026 09:02:06 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2beab3ef844sm15059056eec.15.2026.03.16.09.02.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 09:02:06 -0700 (PDT)
Date: Mon, 16 Mar 2026 09:02:03 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>, "xavier.guillaume@ovhcloud.com"
 <xavier.guillaume@ovhcloud.com>
Subject: Re: [PATCH v2] net/af_packet: add multi-segment mbuf support for
 jumbo frames
Message-ID: <20260316090203.0e138d6f@phoenix.local>
In-Reply-To: <PA4PR07MB7280BF2BBE65E375F5A95FBE9046A@PA4PR07MB7280.eurprd07.prod.outlook.com>
References: <20260309204910.1657193-1-sriram.yagnaraman@ericsson.com>
 <20260309210210.1665888-1-sriram.yagnaraman@ericsson.com>
 <20260310070251.17c934ea@phoenix.local>
 <PA4PR07MB7280BF2BBE65E375F5A95FBE9046A@PA4PR07MB7280.eurprd07.prod.outlook.com>
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

On Tue, 10 Mar 2026 20:02:49 +0000
Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> wrote:

> > -----Original Message-----
> > From: Stephen Hemminger <stephen@networkplumber.org>
> > Sent: Tuesday, 10 March 2026 15:03
> > To: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
> > Cc: dev@dpdk.org; xavier.guillaume@ovhcloud.com
> > Subject: Re: [PATCH v2] net/af_packet: add multi-segment mbuf support for
> > jumbo frames
> > 
> > On Mon, 9 Mar 2026 22:02:10 +0100
> > Sriram Yagnaraman <sriram.yagnaraman@ericsson.com> wrote:
> >   
> > > Enable jumbo frame reception with default mbuf data room size by
> > > chaining multiple mbufs when packet exceeds single mbuf tailroom.
> > >
> > > The RX path now:
> > > - Copies first segment up to mbuf tailroom
> > > - Allocates and chains additional segments for remaining data
> > > - Properly maintains nb_segs, next pointers, and pkt_len
> > > - Silently drops packets on mbuf allocation failure
> > >
> > > This allows receiving 9KB jumbo frames using standard 2KB mbufs,
> > > chaining ~5 segments per jumbo packet. No need for custom mbuf pools
> > > with large data room.
> > >
> > > Advertises RTE_ETH_RX_OFFLOAD_SCATTER capability.
> > >
> > > Depends-on: series-34567 ("net/af_packet: fix MTU handling and add
> > > jumbo frame support")
> > >
> > > Note: Implementation generated with AI assistance.
> > >
> > > Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>  
> > 
> > Using AI patch review finds several issues.  
> 
> Thanks for the review, I will fix them in v3.
> Perhaps, I will wait for Xavier's changes to be in main before posting the next version.
> 

You can use next-net for-main as baseline. But wait until that gets merged before resubmitting.
