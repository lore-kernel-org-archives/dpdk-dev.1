Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA78C5DF9C
	for <dpdk-dev@archiver.kernel.org>; Mon, 24 Aug 2026 16:51:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 856E340270;
	Mon, 24 Aug 2026 18:51:12 +0200 (CEST)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 729D6400D6
 for <dev@dpdk.org>; Mon, 24 Aug 2026 18:51:11 +0200 (CEST)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-381b831d535so5359658a91.0
 for <dev@dpdk.org>; Mon, 24 Aug 2026 09:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787590270;
 x=1788195070; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=eFL0JcX97ms8OKfekfBReSEJruKyr6HHhnNnshJUcYE=;
 b=RKomaDB1V8gLXgHbDWw4LmQgPMD21MHfE9JrFCdMPh4pf6j51zsISNIIA2516cUWHj
 8ABaP0DU7VnFYkEdzXxHBKVEe+PAVw21xhWU3FZ6fnXsn60KVMJoZSi0vUUGcItK0MhW
 wgE6oqNRQ8+B9X1lWSuZJUN7UU/IuTbHN0VGk6hGp0bhgctc5m60yl1UhgsaUhF8UBtK
 +qO5dZgmS1MAGxasRP3t+iwvdi6tz5eh6q2KmhgAyuxu+luPQiYTxZvYs30VUao3vwR4
 a2vQAnOVvnbIGBY8G+8zEjhOZYYv6056JRlidSls2q22xMeKM3sTYnm4tBhGRHAJa0DU
 bNWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787590270; x=1788195070;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=eFL0JcX97ms8OKfekfBReSEJruKyr6HHhnNnshJUcYE=;
 b=o/nKKrJ6s7v56vxwRN4BxWyjYzqP4XV78LHP3muACFlE+YHd0SvwoMePjKWamSi4ri
 xKGd6UZ40DiPdwnI3eTCY1mnrBys5538L6b2KB6CKPWXBf7cdgMicjIh8o1dXzzRmIly
 gkKHtL4vx8KS8MKY/Mo3h38KWs80cu6jUSKKCNVj+BwUDSVKurAZxq7MyAOJUhtr7dKx
 G7BgUYTSjPoohI5oNZmKoDbhZvbYOth0ahGRf0daTPeHNBTgKnrjUAzhaImQ0dVl1DeN
 mtVPFHbdn3SdCEQSvc+vLnrNNDP86KDXOhpZXTE+z2hp3Z8jI8Op3IOXvoEJ24N4nBXF
 ajJA==
X-Gm-Message-State: AFuF++mrG8p47e9ionupWrzeo8by9iWlJO6yOsR9hOhWCbogscW4XIKC
 DfDCDpqPEnctvik6yDg3Anoj382iXj6G9omy+Zr2Jkrjaf63JWytt7ajFDTlyxo7Z48=
X-Gm-Gg: AR+sD134sLUz/cn+vtbEVn5oM3rSL4plZW//0SI3Qmjhs7txllwzFrDhmUzeJ2/4WoR
 6fJ7TCjq/q/f4H0+H01Bx2auGmntEg1DSFdjxi3B9TK+lSbHOmI+zv4T8sGc6nPnJKxObtq8aLQ
 pThGPfc4OaNbBOk7ShsLOJP1oGhUv4nAP2ylo3ZUIj04g+PbveUGg5Vz54/85peHS1A/9aUx5lc
 VZM7ZdCBUbYicrI9MVV+jRhmzCZSeKSX0jADsqycKNTSGsW1913Jz/HAFNQtiZEp6OhJdjA5dnZ
 lg1BoEW0pA8uXI4bET951M37+np7I7O1svO/TQN17HUAB5pc/sUAmaCY9xMxvryO0a2UMvlDFkP
 jROL0JIZjUBC9Vavh0R/ShNRNwi4X2HCBuZYxpa2jky2JZ5S9/+Zsx/NtWMPrpPeBIM1iX2E1me
 7QpSWxsu+8909W1uNmO0h1z7DwY+z9+eONvn2EHdGceup3LZlM5xxiUTNiSxCoVSarGZCs9JINX
 BmSwald6qHk8XZjRgDAchuZNPIefeuEW9ZMpBlsAmFdr7Pwy7c/
X-Received: by 2002:a17:90b:574f:b0:38e:49c0:75a7 with SMTP id
 98e67ed59e1d1-396463f1346mr477673a91.8.1787590270434; 
 Mon, 24 Aug 2026 09:51:10 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645d993d1sm170199a91.15.2026.08.24.09.51.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 09:51:10 -0700 (PDT)
Date: Mon, 24 Aug 2026 09:50:59 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Viacheslav Galaktionov
 <viacheslav.galaktionov@arknetworks.am>, Andy Moreton
 <andy.moreton@amd.com>, Roman Zhukov <Roman.Zhukov@arknetworks.am>, Pieter
 Jansen van Vuuren <pieter.jansen-van-vuuren@amd.com>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>
Subject: Re: [PATCH 1/1] common/sfc_efx/base: clear VADAPTER stats upon
 allocation
Message-ID: <20260824095059.0c37c925@phoenix.local>
In-Reply-To: <4b595977-e358-4170-174d-ff83a368f554@arknetworks.am>
References: <20260824112647.27146-1-ivan.malov@arknetworks.am>
 <20260824090632.687d7e6e@phoenix.local>
 <4b595977-e358-4170-174d-ff83a368f554@arknetworks.am>
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

On Mon, 24 Aug 2026 20:44:18 +0400 (+04)
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> If I may, the premise that the netport branch never reads 'en_vport_id' does not hold water, as 'efx_np_mac_stats' clearly accepts the vPort ID as its third argument and correctly places it into 'GET_NETPORT_STATISTICS_V2_IN_PORT_ID' unless the action is 'EFX_STATS_DISABLE'. The comment is therefore accurate and will stay. As for the "affects only Medford4" claim, that refers to observable counter behaviour for the specific NIC family in question.
> 
> Concerns expressed by the AI do not meet the threshold of an actual defect, and thus no change to the patch is warranted.

Agreed, I just do this to make sure everything gets looked at.
