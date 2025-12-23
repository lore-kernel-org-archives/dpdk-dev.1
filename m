Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B1CE6B26C
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Dec 2025 01:19:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD83D40296;
	Tue, 23 Dec 2025 02:19:48 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id 2059E40265
 for <dev@dpdk.org>; Tue, 23 Dec 2025 02:19:47 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-477a219dbcaso37811415e9.3
 for <dev@dpdk.org>; Mon, 22 Dec 2025 17:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766452786;
 x=1767057586; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PpeugMezzm/4LGTpzJyVLpyUyoiVuHLEDAk8uXukCdA=;
 b=vtCkAHa52wZvbNwlmSE+Ru2ebrP96dPIr/wc8SfO4vUmlQZnhi4piIihsSW0zFssDx
 ZcEPDJUK6P7U6E3TUEkUh+UE8JWknSq1Ol+Pa9CxzD0S5OQLc4JIOblD4ZZWVbhTmFiW
 JY8Gq7rKYKFTkE7fKyV6e4zc7lPs57feeR4U2pnX4ihs9InLqSgGCNod8ILZlSimhP0c
 eCyAd/vB4ofTQ7dbAH4EcGZacuSNxNJoddw1gC7ZpB/u6bSE6hhMV0iMlBKx4jy4oq9l
 oIKKxx7YYuSKlnaDL8oLl8/CaWfFoX1e9x267n3JvdETEKOoTo5hB4W69BKjlyl65F4Y
 GEQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766452786; x=1767057586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PpeugMezzm/4LGTpzJyVLpyUyoiVuHLEDAk8uXukCdA=;
 b=htq3gzqFS9sjJej3o6q1hcrRhTPUaGQMc+jiL+9osV36lNvIVWe72aMLZaF5TtGzzL
 puBJt6FqNuisjatBfIhQJjTPPgrbUPpmPEsVlOfY3GhPz+La0bs9VPjbb/lKlzf+Bate
 2BO/f6gF6ViyYzQuqICoQhpyToR84mfVVEhZquSOKkVk6t2rygrkbnD62nVPwKiFXihZ
 GgfbzKk9H60ALqlXlVhsAnn0RQxoD1avnqPg551gJtBrDoR269wSa22Fc7rv2M+qGK3G
 Zth89dWQCkDy4v0I1o7+NtNHHzAxFmbVoC24RfxWl4p3QRZI2Jn1FV0QDQiLyvB38oRB
 XDzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA3Mkj2QzGepBEjc9g/9vR8RDA9LDX+x6FU3M/eWyNIwpxrZd7Z8c46tda36a7nAMTERk=@dpdk.org
X-Gm-Message-State: AOJu0Yy0W3KpSTFVd0EcPCyHGO5uSA5d2srocW8xBTSHWTTSMryVOPBk
 zN2KwAC1uPpIJuucb+7Uft8JtyesymrWS97g+WT3M6x7UHvDIan24owkXuc4V8IqtEE=
X-Gm-Gg: AY/fxX6oEpF37jdKureyqvJxyQYKpuojgAHPjcaVgWyE8CBnYi2UO2wpJi3Ti6QVUOx
 /bYvrfoZ/0aqGkRzPXhtr8PrMy0yi6Fq7T+Hgt3bm+OVfKNQseP5uXIDAA71wXizhQ6xotpUO6C
 zpZCwVImS8Fd3jWfOvhzGkzwzgqOeEF1D9DWZJqaATQJ+ZU7Ab+z7vwvOMbA6eQdNPGi1e5gKXO
 NPVyLXBhtB2NVdMEthpy6mjDcQ7/DnfLVSdxcuvPBiF46c667MZmFukWMU9L6MCU8RE7FTcCgYQ
 6JtAOxFpI3EoH7QoaELe91GRhXb3Xqc7zyEi2ClmtK1szNObdVfzv2iKXuklcO/fO6q80GcHcPa
 KcQ4+v0i9MG0Jg75KQKMQyIqok+0Snj4xLo0GWlswSDG4gF9+2Pmy2lvyZmyZsOffDXHxck9P9I
 r1jX1/nhMOua1MrTNfwDIDgSLV6kYo5wVu4KceSb9z2osZtJeFnAjz
X-Google-Smtp-Source: AGHT+IFNJKj+rdtWGdtapmwFkiYtp+rEyEO7qc3PFo4MX+m0nbo5SjlPMkmEigxBjlC1MOpp80HTOw==
X-Received: by 2002:a05:600c:8215:b0:477:7b16:5fb1 with SMTP id
 5b1f17b1804b1-47d3884b924mr395495e9.7.1766452786609; 
 Mon, 22 Dec 2025 17:19:46 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be274e407sm267596935e9.8.2025.12.22.17.19.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Dec 2025 17:19:46 -0800 (PST)
Date: Mon, 22 Dec 2025 17:19:41 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Loftus, Ciara" <ciara.loftus@intel.com>
Cc: Ivan Malov <ivan.malov@arknetworks.am>, "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [RFC PATCH 1/3] ethdev: add set link state on close API
Message-ID: <20251222171941.7425d341@phoenix.local>
In-Reply-To: <DM3PPF7D18F34A1CAF2F4F05ECF6EABC8A58E01A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
References: <20250829140224.1748255-1-ciara.loftus@intel.com>
 <20250829140224.1748255-2-ciara.loftus@intel.com>
 <3f8ed682-28d4-c90a-8547-8d1e98595f79@arknetworks.am>
 <DM3PPF7D18F34A1CAF2F4F05ECF6EABC8A58E01A@DM3PPF7D18F34A1.namprd11.prod.outlook.com>
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

On Wed, 3 Sep 2025 09:22:49 +0000
"Loftus, Ciara" <ciara.loftus@intel.com> wrote:

> > 
> > Hi Ciara,
> > 
> > On Fri, 29 Aug 2025, Ciara Loftus wrote:
> >   
> > > Allow the user to configure the state a link should be in after
> > > the device has been stopped/closed. Make this configurable
> > > through the new experimental rte_eth_dev_set_link_state_on_close
> > > API. Three states are allowed:
> > > 1. down: bring (or keep) the link down
> > > 2. up: bring (or keep) the link up
> > > 3. initial: restore the link to the state it was in when the device was
> > > started.
> > >  
> > 
> > Perhaps it pays to name it 'status' instead of 'state', as the latter is not
> > confined to just 'up/down' but also includes the speed, technology, FEC, etc.  
> 
> Sure, I think this would be a logical change.
> 
> > 
> > As for the three cases:
> > 
> > (3)
> > When the driver gets probed, it may discover the link being in some state that
> > the previous driver left us, (A). Then if the user does not invoke any APIs to
> > tweak the link settings and proceeds straight to 'rte_eth_dev_start', the link
> > will be in some best-effort state (B). Otherwise it will be in other state, (C).
> > 
> > Which one is implied by 'when the device was started'?  
> 
> I think what we want is (A) - the state the previous driver left us in. I will
> look to improve the descriptions if there are further revisions.
> 
> > 
> > (2)
> > Does 'keep' describe the link being up prior to 'close'? If so, then if the
> > link is not 'up' prior to 'close', this commands to bring it up, which may
> > not be possible if the link partner is gone or the cable is unplugged.  
> 
> Yes, I guess this is conditional on external factors such as link partner etc.
> The documentation can be changed to reflect this. "Try" to bring the
> link up.
> 
> > 
> > (1)
> > This is OK. If the driver is capable to force link down, in electrical idle,
> > it will do that. If it can't do this, the whole API won't be supported.
> > 
> > Thank you.  
> 
> Thank you for your feedback.
> 
> Ciara

I would prefer that:
  - the link state was the same across all drivers.
  - the link state on close was documented.
  - the link state on close followed what BSD and Linux do.

It might mean that a more complete set of link states was supported.
See Linux operstate. 
