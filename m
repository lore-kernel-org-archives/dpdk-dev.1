Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E94D111A7
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 21:39:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FB4640B91;
	Wed, 26 Nov 2025 22:39:34 +0100 (CET)
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com
 [209.85.160.180])
 by mails.dpdk.org (Postfix) with ESMTP id B8EAF4013F
 for <dev@dpdk.org>; Wed, 26 Nov 2025 22:39:32 +0100 (CET)
Received: by mail-qt1-f180.google.com with SMTP id
 d75a77b69052e-4edaf8773c4so3551721cf.1
 for <dev@dpdk.org>; Wed, 26 Nov 2025 13:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764193172;
 x=1764797972; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kKjhK3NEtUiB4wmpgr5AmM2AvYMUkX0ypLM+40onodk=;
 b=X1cEgIhZ2XVkiZLzkuefNfUsUCBOGWUnEggwiRWOCSeJKOZfhJrJskrlk+CHDZq7O3
 RxuguuU3ImaEqWxR+nMgGi/YafuQQStqzr4HElQI6DbzvQZv/Eor37j8w1ccByzYa0g1
 HjOLspkXNTwqUyDnc8e/vZVrkV9nwkaEZz7kU50mIXt9pe3l0i/QiBKORJZF8S0hHSYX
 0eSAp4Pj3zbjBiDr9Bh5HMVHKKpUYWLsvduyy9eS76JtssVb7fxCTll8ard+JitkATq2
 Ac9LjWahqkeoLNA7D784XrHDCxxeq9mUVbX0AkqHj5ToybjE5uLkwYs6GGZaFAPY+w7S
 qeQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764193172; x=1764797972;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kKjhK3NEtUiB4wmpgr5AmM2AvYMUkX0ypLM+40onodk=;
 b=jBVkTtdYZKMc6id0zZaDUkQ6PmezyiUeMW5WfSVe9icRd5QPc6fnCpCavwVCt3cS7G
 sbFcvZAqbk76DWyUNTD4sntmjIqNrHMy48+Cqwo7AJr0HY0JQYxyB8rjDmtDpwIZrsxV
 HXm0l68YUIYvQ2ux9W4kMffO5xTnMLyzy0fjczArM+Fv3fVnKzPH7Wd9xb4cv5+Cxm3X
 cbPMnMlsY0eZYd7jKKJ6etPP15HlMXGNE/94PDCA8T+G8Bg3oGH3ViRzfAW/F+js9qlX
 MDMXXE4ltDYg6dBSNdWuK3uGa/IATZL8RbG74vaj62Lk5jqhwbDErDIzP9IGxLnJoPe1
 +wzA==
X-Gm-Message-State: AOJu0YwyNvt7QboT3ruCINyLGjknif35SarJzbkoQ7eJ7B5xbHgnP4LF
 3K90OPiOHq8wfXK6G3Snp/V23/Agf2+qOI1Q+5FFjt2IRBqBvSOQTNNfyxlfga3sFib0x+RP7Lq
 F7s6y
X-Gm-Gg: ASbGncuLFMIma/uigUnvNNX6dMzKvhJRKlibfTpRLrgzTxPFAHO2nrh+ZowDrZ4yQ/q
 e8BJK44SR+g2N6/SEjludGYLyowaD9xvIkmOR4o4U4Q8vqcL2oUSSR98okrE2Syc/EQflXvT2/Q
 2PDipGUB3rtfXEmndIZgvEwYV9r8A8Q2eRj5oIlVG7WPneuOQ0BwFQrr7xZ1OTU5dmDlKcfkq6X
 rnk/Ojuya08dxIWyeCKZJ8Bsy1Gqm3UWnSqVB8+4cXfWes8VKhnbknX5nGEquII10nvAXdO9ouu
 mZnkzxh+T62GAUMG3j7wZg2p0KztyVRZ/+umexA/4Ek+vkQPAl6u/aqfCgGhdAidsOCyo6ojQbo
 0pvtK2dWQbNTm5CYu3+hWkvO/UTdzxShEI1x/XhkQ+PbsRo4VjDqXZs79Y1MqSOr+Cca3+iUC8N
 jvBCBjrPlfPTdkYr2af6vULuquCHASSzAdrzdAECZVHCHyIBwVoJTJ
X-Google-Smtp-Source: AGHT+IEEXAS4AnQKEqN1p9VI+PKhdGatqsrILbSBBNZDS8nRH03+6Itw84LX90wA63rPLdGsFYUH6w==
X-Received: by 2002:a05:622a:3cc:b0:4ee:2352:1bb1 with SMTP id
 d75a77b69052e-4ee58a447d3mr346383121cf.5.1764193171975; 
 Wed, 26 Nov 2025 13:39:31 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee48e86bdasm128264231cf.33.2025.11.26.13.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 13:39:31 -0800 (PST)
Date: Wed, 26 Nov 2025 13:39:25 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: dev@dpdk.org, zaiyuwang@trustnetic.com
Subject: Re: [PATCH] net/txgbe: remove the build dependency on security
Message-ID: <20251126133925.7cb06815@phoenix.local>
In-Reply-To: <19590B42346A2673+20251121061951.466049-1-jiawenwu@trustnetic.com>
References: <19590B42346A2673+20251121061951.466049-1-jiawenwu@trustnetic.com>
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

On Fri, 21 Nov 2025 14:19:51 +0800
Jiawen Wu <jiawenwu@trustnetic.com> wrote:

> Now lib security is enabled by default, and cannot be disabled if the
> driver is intended to be used. But there are some functional scenarios
> where lib security should be disabled, just like to enale Tx descriptor
> hardware check. See commit 0eabdfcd4af4 ("net/txgbe: enable Tx
> descriptor error interrupt").
> 
> So remove the build dependency on lib security for the driver.
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

I would like a review by other maintainers.
Several other drivers including cn10k, cn20k, ixgbe already have
similar dependencies. Can't the security library just have stubs
to always return NULL if not used.
