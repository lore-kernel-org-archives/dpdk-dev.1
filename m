Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3503BCA0EE6
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 Aug 2025 16:29:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D5BB402ED;
	Tue, 19 Aug 2025 18:29:34 +0200 (CEST)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id C6B91402E4
 for <dev@dpdk.org>; Tue, 19 Aug 2025 18:29:32 +0200 (CEST)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-45a1b05a49cso40736655e9.1
 for <dev@dpdk.org>; Tue, 19 Aug 2025 09:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755620972;
 x=1756225772; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kvXhfLDQYvIDDsNRoFuivxQ2nnrzGcUU2MMm9+Rgx9w=;
 b=DYoZC1HLKhOHgEhUncLynNZJ8xh6IiF+JEVDdnB4dkKPm73XbDFLseYJhlO4USj04r
 J8jyZGpIgU0q8JoZIHSJ7fMPVnhBdE/GZuoWn3bjOB8C3SpObno2SJ+K0apY8TYUWScw
 64k/RO0Ggn0fOXCdXXq1d0hGu9OdJYkepSh2W/xMviDB4EB/KDr+qsY+9L7AQO1LvAl/
 TwKFMQ0RxMrz9+UoJcOckn3l+boNXclES/peh44g5U3uYWZR0EZmJ96866ShEcZoWMxm
 SeWESGQ0uHGVG/zOcIhc4bqTUf1BgzYX+AFOVwnyCGgTdA0Z/+a9WZc3oM17EkQj87+Z
 762Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755620972; x=1756225772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kvXhfLDQYvIDDsNRoFuivxQ2nnrzGcUU2MMm9+Rgx9w=;
 b=qvOqbGT4VKsWlajWhfqi3EfLHppQmCr8hHXGDnoDfLSH702Q0FjjGr3Xqzp+q7AE6O
 CFnf4U1l1h+HozT69deJGxKY5VGMaQR9LEWWRW6XNzXVeYQGHY5woubAmRE20JRrCJVL
 Ihq9m/0JCvcS9tj3KcFB0a3rmnQsMLFvqdr3n78L4b88zTDtMdmcjOn08tTmWJ+fOevg
 fpqL4S1sFDjAI3nCVsrhZmvVf60cgrZqmVLuc786lYGsy15qfSLy7vH5QK4H9bzFr7ZT
 SllacUtdBJixY2KAIA2gejDSwabn95eeXaki/t1LDMPS9m5MtILXm2a+SDQJ8czifRP2
 tj3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjJNLjSVjOBh2MO5svfr2rEkGU8lBCdvwcSXUqe3JhdjI8U+fTV6iUfCqjz6Y0ApjpITM=@dpdk.org
X-Gm-Message-State: AOJu0Yycsf8Wrjii9RTbyQHHJzpMEsfz485WFVFrOzSrNxeeF4X7tWgc
 untli/ISXup0iQTpBlxcR0O9sLkuuVbrA1+vcD934c0z45n2i+6/2oz7F69jx0tfis0=
X-Gm-Gg: ASbGncsh6fMPtoyGFPFvW3IpIDfnZrCZfaKzym1k7HIRSA33tJ9mCIDRya2vNUHBdPx
 lIdql5vu1Lnkm49I5YJwNZe6HLoPOIc6jcH+xxHq0J8LHqcOJ0DSIK00D8GOhaGfFG0imEaMsgL
 HtVqjofOppDc5Cj42H3TuLQCZr77NM9xKC5mnsqtNcMNwsvfTu8+vxZuCI9wJjhPbo8bbq89KL7
 J6CZKeH0d4IpqwJbaPtdOqMwNLgBbWrJ8/5oTibMpasQqRuEbKiE2b1qefzM8WEiohlit3J0o6H
 sOKnsoQ8UQI/MqRcsWq82H6MXFb6ixWPu5DaK53yA3D5wX0krxRlPzIlNOiTH371e5WJ+4AWJaD
 VS73JY+9EivADVJtkb+xorhYtZPhPltccYjTyYVV6VoLDLtnPRQMBKjCzNdQr17g+DHVLAjjRvM
 I=
X-Google-Smtp-Source: AGHT+IFAvXuas+4NZNHbDyYa4fHo66y+gtzapR9+xAgaVmkNuseArDXZyc5CfbVxli1/Jqt8yYPRIw==
X-Received: by 2002:a05:600c:474f:b0:458:bdd1:b7ef with SMTP id
 5b1f17b1804b1-45b43e00aabmr31959875e9.19.1755620972275; 
 Tue, 19 Aug 2025 09:29:32 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b42a9847fsm46173585e9.26.2025.08.19.09.29.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 09:29:31 -0700 (PDT)
Date: Tue, 19 Aug 2025 09:29:27 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <skori@marvell.com>
Cc: Thomas Monjalon <thomas@monjalon.net>, Andrew Rybchenko
 <andrew.rybchenko@oktetlabs.ru>, <dev@dpdk.org>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>
Subject: Re: [PATCH v5 1/1] ethdev: add support to provide link type
Message-ID: <20250819092927.739f64ec@hermes.local>
In-Reply-To: <20250819055126.2745262-1-skori@marvell.com>
References: <20250814081215.1904078-1-skori@marvell.com>
 <20250819055126.2745262-1-skori@marvell.com>
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

On Tue, 19 Aug 2025 11:21:06 +0530
<skori@marvell.com> wrote:

> +/**@{@name PORT type
> + * Ethernet port link connector type
> + */
> +enum rte_eth_link_connector {
> +	RTE_ETH_LINK_CONNECTOR_NONE = 0,     /**< Not defined */
> +	RTE_ETH_LINK_CONNECTOR_TP,           /**< Twisted Pair */
> +	RTE_ETH_LINK_CONNECTOR_AUI,          /**< Attachment Unit Interface */
> +	RTE_ETH_LINK_CONNECTOR_MII,          /**< Media Independent Interface */
> +	RTE_ETH_LINK_CONNECTOR_FIBER,        /**< Optical Fiber Link */
> +	RTE_ETH_LINK_CONNECTOR_BNC,          /**< BNC Link type for RF connection */
> +	RTE_ETH_LINK_CONNECTOR_DAC,          /**< Direct Attach copper */
> +	RTE_ETH_LINK_CONNECTOR_SGMII,        /**< Serial Gigabit Media Independent Interface */
> +	RTE_ETH_LINK_CONNECTOR_QSGMII,       /**< Link to multiplex 4 SGMII over one serial link */
> +	RTE_ETH_LINK_CONNECTOR_XFI,          /**< 10 Gigabit Attachment Unit Interface */
> +	RTE_ETH_LINK_CONNECTOR_SFI,          /**< 10 Gigabit Serial Interface for optical network */
> +	RTE_ETH_LINK_CONNECTOR_XLAUI,        /**< 40 Gigabit Attachment Unit Interface */
> +	RTE_ETH_LINK_CONNECTOR_GAUI,         /**< Gigabit Interface for 50/100/200 Gbps */
> +	RTE_ETH_LINK_CONNECTOR_XAUI,         /**< 10 Gigabit Attachment Unit Interface */
> +	RTE_ETH_LINK_CONNECTOR_CAUI,         /**< 100 Gigabit Attachment Unit Interface */
> +	RTE_ETH_LINK_CONNECTOR_LAUI,         /**< 50 Gigabit Attachment Unit Interface */
> +	RTE_ETH_LINK_CONNECTOR_SFP,          /**< Pluggable module for 1 Gigabit */
> +	RTE_ETH_LINK_CONNECTOR_SFP_PLUS,     /**< Pluggable module for 10 Gigabit */
> +	RTE_ETH_LINK_CONNECTOR_SFP28,        /**< Pluggable module for 25 Gigabit */
> +	RTE_ETH_LINK_CONNECTOR_SFP_DD,       /**< Pluggable module for 100 Gigabit */
> +	RTE_ETH_LINK_CONNECTOR_QSFP,         /**< Module to mutiplex 4 SFP i.e. 4*1=4 Gbps */
> +	RTE_ETH_LINK_CONNECTOR_QSFP_PLUS,    /**< Module to mutiplex 4 SFP_PLUS i.e. 4*10=40 Gbps */
> +	RTE_ETH_LINK_CONNECTOR_QSFP28,       /**< Module to mutiplex 4 SFP28 i.e. 4*25=100 Gbps */
> +	RTE_ETH_LINK_CONNECTOR_QSFP56,       /**< Module to mutiplex 4 SFP56 i.e. 4*50=200 Gbps */
> +	RTE_ETH_LINK_CONNECTOR_QSFP_DD,      /**< Module to mutiplex 4 SFP_DD i.e. 4*100=400 Gbps */
> +	RTE_ETH_LINK_CONNECTOR_OTHER = 31,   /**< non-physical interfaces like virtio, ring etc */
> +};
> +/**@}*/
> +

doc build fails when you add this.

Please test.

[30/1996] Generating doxygen-html with a custom command
FAILED: [code=1] doc/api/html 
/usr/bin/python3 ../doc/api/generate_doxygen.py doc/api/html /usr/bin/doxygen doc/api/doxy-api-html.conf
/home/runner/work/dpdk/dpdk/lib/ethdev/rte_ethdev.h:335: error: Member rte_eth_link_connector (enumeration) of file rte_ethdev.h is not documented. (warning treated as error, aborting now)
Traceback (most recent call last):
  File "/home/runner/work/dpdk/dpdk/build/../doc/api/generate_doxygen.py", line 13, in <module>
    subprocess.run(doxygen_command, check=True, stdout=out)
  File "/usr/lib/python3.10/subprocess.py", line 526, in run
    raise CalledProcessError(retcode, process.args,
subprocess.CalledProcessError: Command '['/usr/bin/doxyg
