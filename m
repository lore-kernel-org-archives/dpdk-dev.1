Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC6CCC369C2
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Apr 2025 14:51:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70892402A9;
	Mon, 21 Apr 2025 16:51:11 +0200 (CEST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 6AA9640299
 for <dev@dpdk.org>; Mon, 21 Apr 2025 16:51:10 +0200 (CEST)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-39c266c2dd5so4179379f8f.3
 for <dev@dpdk.org>; Mon, 21 Apr 2025 07:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1745247070;
 x=1745851870; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+KKzY4fs9J3tSfMQyZv9ViMxPEnXnsttRi43034XSGI=;
 b=A1DGt4P9bZ7WwRRQYO1xWtMk/SrrJ0wYOJyobaNwNZfnv/rvu0N/cAcHVc1A0Pno7l
 HcNeWC4cdWcUSTJwSOFxoUD63c6RWG1w9SB16fg9GFc3nZhABJPrg0ThZ/egjQsfJklp
 eqNzcJLgzH6PBXbh8yTj7dGDnw/vpyy7ytPHKYOkH1t0bVlVbLdKKdkUqrEuH1kRUtUZ
 E+9Q/2ktfTvRhwjb4bQRIMmkRZWlrwP4/mQPzC+ocnbzCucPEcz/aZWm42SZobxBZgPr
 9dq1Uf51K9jEdBMTVvTBKUvpn5TQ0Ru6TV4/xdZzxW+9evX3zUghepoEf5GytzS5Vear
 uKOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745247070; x=1745851870;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+KKzY4fs9J3tSfMQyZv9ViMxPEnXnsttRi43034XSGI=;
 b=GHS0vLufBMwZC+rAK6RhQbN4/26ex1MsCGErDhPaDrAy845oG3Hm1dBH2Apw4warZN
 RnM05lRctuhkCT7dcisos6////+odSqnitZaEqdQeH89VnyugXsO4vY0NlAFuAb0hq+0
 UcWhLTowUT2IhjlvKaGN4vaPmHSZvvA7DhDR2FEip/M9FXMJOEteMpCdTjiTn9hM/djV
 88un7Fh0GGQxZeXwdBVV7BKMDnBZVSCIEMWYeEwge5TGZAgbHXz4IZnp/6W7eEPDjtkN
 jqbmwGWydiFxvEc7fR4jebWRINDiO4fdCz7Zdd6d4iOUlG+9fFelapNbPrpMhsRv5xxG
 1QZg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUkMuw/PcT63va4DJMxzOacG6wU7iQ3NaIITFVYwKBBfA3YEdL8NdElR4pV96pzjQUo/Zc=@dpdk.org
X-Gm-Message-State: AOJu0YwU57TfvQYnRIMvyJvKUwo65LjH2IsXOAr/cNwv59vkX85YWp5k
 6a9TMP8oLpzsOEc8EMPceiZ5dYlVWkPCf2YcNCrXLh/ulS//7Ig4lz+4spnJH9M=
X-Gm-Gg: ASbGnctTU2/SVjFsYwQft0wDNkMB4rgS7h5tOJGdUqZwU3yob6vjkc4pXF+osLHmu98
 BPP2aFK4RGohmvi9gU7uO8qtumGb90P+P6Yo387RwXF8u8C193Ou72wfNpkF1NHLfMz/R00EtBL
 Wpzcy1ecf+dF90FUTp4ZlfZ3ZbK/CTB46qECIjM7uLEDiL1LnFP4DvYIi7HUSk68lB5nN9JV/mK
 AAnwIsuP6ArZuqW0k4m1zjO8tYNcvmd3W+813GnhnoAveUX0qFUfaS3/PlAIdxnzoYWmjMcCKmo
 BROwfHdfNw0MPkdRH5NUDbKsmBH20gYNN3FMfXubPucZ6OXkOZdRWhLFtW4G/2ZeiV/sUjlj8Q3
 NtDFdN43seu90XUm3
X-Google-Smtp-Source: AGHT+IHbdomq5C7qVXZIoEn+ICLEoOLprdP48+cWHz7SZoaTUdJZYZwd9OKjXrj+WN3rAsajFoF60Q==
X-Received: by 2002:a05:6000:18a8:b0:391:1218:d5f7 with SMTP id
 ffacd0b85a97d-39efbad7d6amr9067037f8f.40.1745247069759; 
 Mon, 21 Apr 2025 07:51:09 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5bbd7fsm137072775e9.21.2025.04.21.07.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Apr 2025 07:51:09 -0700 (PDT)
Date: Mon, 21 Apr 2025 07:51:01 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: <kirankumark@marvell.com>
Cc: Ori Kam <orika@nvidia.com>, Aman Singh <aman.deep.singh@intel.com>,
 "Thomas Monjalon" <thomas@monjalon.net>, Ferruh Yigit
 <ferruh.yigit@amd.com>, "Andrew Rybchenko" <andrew.rybchenko@oktetlabs.ru>,
 <dev@dpdk.org>
Subject: Re: [PATCH] ethdev: add support for flow action pop E-tag
Message-ID: <20250421075101.58dffd0f@hermes.local>
In-Reply-To: <20250421115134.841719-1-kirankumark@marvell.com>
References: <20250421115134.841719-1-kirankumark@marvell.com>
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

On Mon, 21 Apr 2025 17:21:34 +0530
<kirankumark@marvell.com> wrote:

> diff --git a/app/test-pmd/cmdline_flow.c b/app/test-pmd/cmdline_flow.c
> index 998527590f..c4359e965d 100644
> --- a/app/test-pmd/cmdline_flow.c
> +++ b/app/test-pmd/cmdline_flow.c
> @@ -652,6 +652,7 @@ enum index {
>  	ACTION_METER_STATE,
>  	ACTION_OF_DEC_NW_TTL,
>  	ACTION_OF_POP_VLAN,
> +	ACTION_OF_POP_ETAG,
>  	ACTION_OF_PUSH_VLAN,
>  	ACTION_OF_PUSH_VLAN_ETHERTYPE,
>  	ACTION_OF_SET_VLAN_VID,

Putting it in the middle of VLAN stuff seems odd.
Maybe put these in alphabetical order.
