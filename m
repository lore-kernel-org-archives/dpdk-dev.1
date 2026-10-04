Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0984CCA5FEF
	for <dpdk-dev@archiver.kernel.org>; Sun,  4 Oct 2026 16:13:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7282402F2;
	Sun,  4 Oct 2026 18:13:38 +0200 (CEST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id D561740285
 for <dev@dpdk.org>; Sun,  4 Oct 2026 18:13:36 +0200 (CEST)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2caced6038eso3696725ad.0
 for <dev@dpdk.org>; Sun, 04 Oct 2026 09:13:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1791130416;
 x=1791735216; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/jQR/9truhUhM/DrCQ+QEgHhVcLuzuNlHlaH13vfVoA=;
 b=E80JE3L6q9xB8PPQ1Nyxfa+OKQ4dMfCcundk+R82L+nP72sZbouHOiYdY5jQ85B3TH
 UNaAMk+If+D1/oDnTxdOLC71fgjToc3+DMInd46juflO7IQm8R1+DRDlNSfakU44aAly
 hcfMNvKHHoAKMfx3J9wlSAqLscQ4FF73a+BzEQ3bI/c6CQoAg4IpUf8YqBw+2KBXQQ+N
 s0BW0LHWNH0+qoqHCUKzUDtY3YGscN6QdSogWiGBSwhYLHGIDovkYbtSgqTRfymSkPF8
 d/hv+fx5djWYpezFykmAS3plFhsj5zwIAxf8W5qwKE95OPcHAqtGEdWQH4JBWAqN1mpJ
 4V9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791130416; x=1791735216;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/jQR/9truhUhM/DrCQ+QEgHhVcLuzuNlHlaH13vfVoA=;
 b=okS4Y2Hqc9Cqcq0rEItNPCgnTz1znzab9nFFl4tQw7ywH05P+y8LlJYe+KOXYHmfQz
 WDc9aFFcYZ1e2LWPkWG3Nvp/iJV6tphQ97I3z7dZneO3ZKuE1MpGmOg73leQfTn9BL2x
 hwwLM/Z503OTtcCK/x08lmEqvQ7Vb6hwGcABzpwKa9nORn8HctTH9fujrBr0WiHsRod6
 Fah+YWo1+xDkpjkK5neTPREnGThzRnP0sdMpwreGcNa+8RgOZg+Ov9enqvO7hLWR8Nj1
 Qq2d6S0drpJyfvzwhix7pNDluL87fyRyfm8u69U1IYotVbxFXyx7KEagH7lEEvueCV6e
 XEmg==
X-Gm-Message-State: AFq9FYIKo9uGfwe1Y6CrzW2+8buyNXThg4XRydiC+7DgWTD0WkeSJ1Qc
 jWyoQbSEqkhsg7Pl1r+17K7RzHVHlv8LRNR2Z9Xcm3cfWUsCXdjzetvW92WEpF3Dp+4=
X-Gm-Gg: AYBFou249gokf+34CxeEvwaoU9VuamYQKSlcHZ/qdRAo/7fHn93sQGJF2TQ6achIO/f
 tJDpZnY4eferhjlQy2Si+jl1D2C6/H+MyPn0YPU6iVlaOvn9yrt6HrhOviAKvj76FCWvh7UYMnD
 4pWQp64/o2JWAWM1X4tcEp+sU9Ri5F1j28bkK2LwfB1bNPJrUH71VXAP4VJOUJG1wfDvyFtAuxc
 RHYx2RFz+FegNGVRjmdS6Xki5PKvPU1YzC8yiGwFtwSUa8ModrZpeDmSCCei4z/C14U4ljpA5xE
 fQVDyBG1/ira5TDfXh9EZ3RSHvwUOEjR9IB51yCbSnOx6OURMAh3jR8aFXaqIMA2S9T2XKsK4Nl
 O0lKXYDPe+zidEZgNK+2av1Hx+jckbgQ8Uz+T6i5E7V1ycyo827kAuRq4JG3OpXfHvPPg440cWZ
 U7ZCkyWgxqt8dcbWS6rmb4j90dtPu16x5G+bxSI8QO0yc1YWlj8bxM+Zdnsp2q/BudsZNE0Uejh
 j96//C1zNNVRlnz4sHp0npkYl4Ox8ZaR+hFJrxfrZFXJ50/G3Y=
X-Received: by 2002:a17:903:4b50:b0:2d7:1cbd:9ceb with SMTP id
 d9443c01a7336-2e3000ece4amr75652485ad.12.1791130415875; 
 Sun, 04 Oct 2026 09:13:35 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e56defa166sm4642555ad.5.2026.10.04.09.13.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 09:13:35 -0700 (PDT)
Date: Sun, 4 Oct 2026 09:13:33 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Roman Khromenok <roma55592@yandex.ru>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, Anatoly
 Burakov <anatoly.burakov@intel.com>, Vladimir Medvedkin
 <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH 0/3] net/intel: make link state configurable on device
 start
Message-ID: <20261004091333.6585bf1b@phoenix.local>
In-Reply-To: <cover.1790970122.git.roma55592@yandex.ru>
References: <cover.1790970122.git.roma55592@yandex.ru>
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

On Fri,  2 Oct 2026 21:43:35 +0200
Roman Khromenok <roma55592@yandex.ru> wrote:

> Starting a port always brings its link up, so the link partner sees
> the port as soon as the application starts it. An application that
> enables ports only after its own configuration is applied, such as
> a firewall or a switch, cannot keep a disabled port dark: it can only
> bring the link down right after rte_eth_dev_start(), and the link
> partner may still see the link flap.

The point of start is to signal that the application is ready to
send and receive packets. I would expect the normal startup sequence is:

  1. EAL init
  2. Detect devices
  3. Configure internal state
  4. Configure devices.
  5. Start devices

A device should be dark from 2 to 5. No packets coming in or out
and link is down.
