Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F32CC83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 19:26:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 66968402D4;
	Wed, 23 Jul 2025 21:26:36 +0200 (CEST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by mails.dpdk.org (Postfix) with ESMTP id DAC8D40267
 for <dev@dpdk.org>; Wed, 23 Jul 2025 21:26:34 +0200 (CEST)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-4ab81d0169cso3695831cf.2
 for <dev@dpdk.org>; Wed, 23 Jul 2025 12:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1753298794;
 x=1753903594; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o6UVmmWQeb7cYz1Laq5rK1uuamD1PAjt+tqOHyMq/j4=;
 b=jIRA4aI0Dr98ZN2HAJliFmdiUp8pkfmhlh1WL3ngAPOTrcH4gTf87X62d0e4mvDDaD
 7aRuRvkRmAa7fB9o//9STbjxuSSbyCWKD+UoJ14XRlE0/yUQGhKyJ9aMfg88JfPJ0NRw
 xfpxS29G58dcif2XTKseUVPcJtztBH0+GVeTZjGT+LbJFS9EApnjbkVE9739X03Pm5qD
 HEpQ18RZiv8wrqiejFMqNdeXLcRNrpy2rhCxU2CPYM5i2pJbUel77Fi9woKVLAJbfutp
 +3r5Q9HuTj+BC75fRX9csfikgRg70V43xXEu7xjac6w2Bz6h+KGFOnab7m9zsncGer7C
 JkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753298794; x=1753903594;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o6UVmmWQeb7cYz1Laq5rK1uuamD1PAjt+tqOHyMq/j4=;
 b=Obr0UHQ6G0h5sQW/WHzgZaVmQvX+brd6EZgRNEZpe9PwxvlwXpUY5XKrgw4+cTEIuG
 3U+LMB51iEqGlyEY6CxsVrNRZPyG3BUE6PmrofFQdBSskWe/piZ0sqPEp0iOWkXUxVUl
 wMR+w/yVazLLyPHSzoLFNPjQA0+GHeXBlQxuRis/iz2tJJnbyXP8uydIBwWoGjKgxSuK
 m2lJz/hZjWgmH7SktDxtCxdqsFBaEPFREBujKzSjjJuHKYsS8W7mj0jaNdtZyePj/fi0
 lusNcRj6hCx7ppVcNnR2h3T49JWfdBxWCAiz9APhERC7UlCL6oWwuN0xzl0yGufq91oN
 Umiw==
X-Gm-Message-State: AOJu0Yw4B1n5WY9p7ADW0fUYHKCQlbICZYUt7K94/yrHhjnOKgfwtEnH
 vWOM5x/bTxDZe/7ItQJktJq0tSrdMDWESIPPxaLoEFiVo6ybYUjBMi6hYaG/qqTmAOc=
X-Gm-Gg: ASbGnctrPWhsWi+5mkQMox1JRkE77FkgVMbVK5dHaxabnRho3O65w7sBy1NJ666ovQD
 NdKpLof6JH5zcy/ViqtgDGdN94HDDl8UNwjbRZ6SNRW88b+uAfEHM3sOOIobys+RpCi1EMW8z57
 5ASlJCMWSFaEvn39aN0YZb33ntXv4DhmIlShzcxsHyELbbP6fJb5kzEU8/Xqqe6/rcI9HUavw8E
 cC9jRdxQZlx9AKpQCV6J9rwoAvEAZt2om5+o/1eGtot9S6aAG9ALfSvATLTvJCC750luGAsnXXo
 TMuizbOFxMHdVzE/uWO50iiGDS5vXfXG5GM+7L/XWdD0wxq18S1FHf+4JszQXURK/G2p8QgS26Y
 0LYOhBLqoNEooLKR6/cv+lpPfdKrcaNdOL/9ZQoJATtaIHoFjtkLNSojqVfpthacmd9SaEsQjyI
 Q=
X-Google-Smtp-Source: AGHT+IEEVxo290VEr0OQy1mliB07U03iqKicE8C7De0gkkyuO4mGoeQ6tbXly49tQyn8V3A9/WH8sA==
X-Received: by 2002:a05:6214:4f06:b0:707:92b:477b with SMTP id
 6a1803df08f44-707092b48d5mr25718636d6.44.1753298793760; 
 Wed, 23 Jul 2025 12:26:33 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7070faf5bf5sm354856d6.12.2025.07.23.12.26.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 12:26:33 -0700 (PDT)
Date: Wed, 23 Jul 2025 12:26:31 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Ivan Malov <ivan.malov@arknetworks.am>
Cc: dev@dpdk.org, Reshma Pattan <reshma.pattan@intel.com>
Subject: Re: [PATCH v6 12/13] app/dumpcap: use port mirror instead of pdump
Message-ID: <20250723122631.3af7f58a@hermes.local>
In-Reply-To: <b2c6635a-0cdd-351d-cdb1-b3101a5cc247@arknetworks.am>
References: <20250411234927.114568-1-stephen@networkplumber.org>
 <20250722173552.184141-1-stephen@networkplumber.org>
 <20250722173552.184141-13-stephen@networkplumber.org>
 <b2c6635a-0cdd-351d-cdb1-b3101a5cc247@arknetworks.am>
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

On Wed, 23 Jul 2025 07:16:07 +0400 (+04)
Ivan Malov <ivan.malov@arknetworks.am> wrote:

> > +	/* overlay new header */
> > +	nh = (struct rte_ether_hdr *)
> > +		rte_pktmbuf_prepend(m, sizeof(struct rte_vlan_hdr));  
> 
> Prepend? But what if this is an indirect mbuf. Is it OK? Just asking.
> 
> Thank you.


Dumpcap doesn't use indirect for reasons mentioned in earlier mail.
