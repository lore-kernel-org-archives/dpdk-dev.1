Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30641C44508
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 00:58:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B9A64021E;
	Thu, 22 Jan 2026 01:58:44 +0100 (CET)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id 79745400D5
 for <dev@dpdk.org>; Thu, 22 Jan 2026 01:58:42 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-42fbc305914so314257f8f.0
 for <dev@dpdk.org>; Wed, 21 Jan 2026 16:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769043522;
 x=1769648322; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ChN5eOCV05YmIzwNChLIOvsEEI8t01wlu8l6s9u9PeA=;
 b=jHhOsRO1i8lG8KxwetPP16Q2ZUdbyInvvpGoUVNZo9rxqCkeLMa/p5x0WdRK4BdEQv
 EtoCeBlg5s3jM0Z99bFyFp+1pXv+4U7gjH+DcJwveL0sVjU5k5ImZbban00NG5yVFZEj
 om87GdA6LwbGnZE+w/Jz/he575sGhEz6w43kJzSP6L5nVHbxZxg6Rp83s0ezJl6sNgzR
 l1VSytjjTB47ZSiCjg9hUVQNLo7lbiPCJNqo6Qu1Vhh/gjQevVsfMkZSN041ivPVeGwM
 Pu5gfcOIFcRA8387YWjvd5hmPIoDfYARMzDe4AkZEugzwvWGJeCi9yvhci4CSH8m5Tsy
 DvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769043522; x=1769648322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ChN5eOCV05YmIzwNChLIOvsEEI8t01wlu8l6s9u9PeA=;
 b=JGCPb6H0BSgxSY4DQFWl6g2V9UPupP9lrmjzbuXwj3ZYJ4GoOFw7Ib4ZZ67LPIIHCx
 J9fDewT/kEMiawNF2CPMoTFq5Ie0dKX6TEtir9itVvzIBLjkTMQAO56f2gB5GtwB19ym
 cm5joUAyK6K0Jvy0Vhzyd/IHW/syWNgNEaybtvkNY87L5DvkYQnoi4C58uNjnOSQjVWA
 EbYB5yufv7B2JMJdJoIijFs5qW1P6b2eKTMr436IYJyPjCu6hGzyyeZS0ABG1zQ7jTz2
 eb/zGTbt2ISvGG0luEUhK2aJyE7bFuxRcgjI5Dp3eLV5PZckWLjW2ZDkK/Eh4yGBU/Su
 ddWA==
X-Gm-Message-State: AOJu0YxXZiR1Zljl56KvGOFUPSRuxr33vsGCfAh5kBAuKNvDfHGOFWjr
 vTjABblZHAK5eTtcoO9tDH+vlURUKjRu13RJB2rqm2/42RqJJgG6Qe9DIBiO2amGey4=
X-Gm-Gg: AZuq6aL2zrBQ19BlPx9f2XH2ggLSmdIDFMTUVtDTxyLfe7PXKu+tI7QTLeYoF6piDkF
 MIpiy1YPFi4Ua9XZb9y+RZf9GvmJ/xtMs2RwUg4uBY3OaV0yIhamUwdLbRnNOTYKAxtD42GHvEh
 AyYefMhvQPmI5G5wfIu4DR5aMUTeaafNwuUmaq8yZDsiTAoku4RmynAUUftTTeK32j1XicR37XS
 WgUUd8PIzfyk1ScA0QEImUjSpZzzH2mHd+MynPK4d/NOs8mBOQa6Y8XccWem1aUwWMyAdcMOkNB
 NVF5PippeDj8XiiT/J2CUFvqBBP0cbwLSi+In5q5jScxXy2p0wAOdCQB1mrBwRoYTKc59b4YGNB
 EyAowQN1S0WCDyIupZKB35l3ffrwPL0dO1wqyVBLbMqXRiqCMS+Lxd023tLOMKbzUtAXJeqaDIz
 jQHzMz7y9DvdmFZDYrVDyd26N9t7FXpjYFvs1W8WwDHXWnwSKiY7pq
X-Received: by 2002:a05:6000:2012:b0:42f:bad7:af76 with SMTP id
 ffacd0b85a97d-4358fed8000mr12688931f8f.15.1769043521961; 
 Wed, 21 Jan 2026 16:58:41 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43595609c8asm13012541f8f.34.2026.01.21.16.58.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 16:58:41 -0800 (PST)
Date: Wed, 21 Jan 2026 16:58:34 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Jasper Tran O'Leary" <jtranoleary@google.com>
Cc: dev@dpdk.org, Joshua Washington <joshwash@google.com>
Subject: Re: [PATCH v3] net/gve: add reset path
Message-ID: <20260121165834.24854376@phoenix.local>
In-Reply-To: <20260121220035.3090402-1-jtranoleary@google.com>
References: <20260121193018.2728602-1-jtranoleary@google.com>
 <20260121220035.3090402-1-jtranoleary@google.com>
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

On Wed, 21 Jan 2026 22:00:35 +0000
"Jasper Tran O'Leary" <jtranoleary@google.com> wrote:

> Currently, the driver does not include any reset functionality and hence
> cannot be reset by the application. This patch introduces a driver
> callback for the `rte_eth_dev_reset` function will which reset the
> device.
> 
> Also, as a precaution, null out device pointers to rx and tx queue
> arrays when we release the queues during a reset.
> 
> Signed-off-by: Jasper Tran O'Leary <jtranoleary@google.com>
> Reviewed-by: Joshua Washington <joshwash@google.com>
> ---

Thanks, updated to this version in next-net
