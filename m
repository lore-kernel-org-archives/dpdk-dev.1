Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A654CCAC582
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 19:59:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B8D7540648;
	Mon,  8 Sep 2025 21:59:21 +0200 (CEST)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id 3CA8140615
 for <dev@dpdk.org>; Mon,  8 Sep 2025 21:59:20 +0200 (CEST)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-3dad6252eacso2147396f8f.1
 for <dev@dpdk.org>; Mon, 08 Sep 2025 12:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1757361560;
 x=1757966360; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uxGdRZixqrM3UOC4Pw/eQWt4KJvs0ZoMzrAAysP1Lgc=;
 b=ugaE2xPOop6pDvx4uNIcJSpQ/ZSSs5ZbAnAd9TRzErs61rRsEkBcR1cttHRb6YIXbQ
 A5WvNehZ/gtGUMFkUmlL00l2UPz9/qN0WszQBekZILrXQYRv7WXZaQO7r3o9VkcyHVkV
 ii7DREBDUTWeBtEKXP+DVBbPkJBFFBiKZfVLg+eL/AuhkpWLtE7sV+R6TDfz+qL1M4mv
 pC83P+p29yxo5xfx4NQmKpd3jgRBuhg+YVPqLTlmo1tjhkxk7fqTTX9W2c+1J0JKGyGM
 JiZDru/TOlQFWsiNlev7uifZ8vS0JC+UQ2Op0WpPgra+oCDcdmLW3oTqXX+DafyqQdDK
 glrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757361560; x=1757966360;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uxGdRZixqrM3UOC4Pw/eQWt4KJvs0ZoMzrAAysP1Lgc=;
 b=ru2w6EEjmKgambyEu3v0jRheObsNBP9ORwtTZScejOpvHwrVWL4plfppJH2fLA+JAj
 rugV3WunmVYK6mtEBRNv2C222U9OgVM2i6h/sqzSn/LQSTldcvv1/6MWZbo7LUVMwUrv
 hyzYvP4wnCMuXAxRP1LycECpVvev+6HDhovUZE8Hlf2c7XpaO2JmPNULFylfUUze3qSb
 JHoFSRTILcQqVbwX8X2sYxfGFeudLu4MiECQ75F7KXEmxX0DZDGNosTwlyX8MqcA+/7E
 y+Ggt/e4zanrba7wOw4XcarFMWpJjrH6PRnceHkLpSdAvE/u1qXx53VeCPuh0q59kTdP
 UHUQ==
X-Gm-Message-State: AOJu0YwVLlxyISNNBqE6QB8H2G0VkXYM9S9/T3Q1x62cHOCaPtbupjPT
 mwR+aeBKsGIjtXKsgitZ2hFCafkid9vDVhNYtA2m0cqH60rala+P0ty0TKKnijDoGB0=
X-Gm-Gg: ASbGncuoFJlLKccWmSRqpfjjAU71vOQGxJNEAsmvxbc1hXJEqXm+3zwWbJB18JIg2AQ
 ZOv7swhMA/pt+OUlxpQYjmcRFqJOqP7MH5Flc8OMPfgFf+6wENjd9khnD/KAQ3lTm/uOsKLfGCO
 y7qPNa58diwiiz8XP4uAY9UCvCSIDHTjyYwftirdEOtzNVgyXtez20i6g4pAM4XQxMwU2VpExeb
 +9WmcTCoIkaRd2myqVp+x0dRxW0f5sESCS4bER2Il40VAO1V5D+QTp+0gMXH9WSCYA2Giq6BraL
 dssMisuoFEzsZy5gJvHWOSMet3x36OLXyNlpfIfSwnPYVVcd2xQ9aubTO5fzItdGfNkoWN7PpN+
 ExCcFqCvd066ON5Pe8ljTU9fEyOVF/2weaj7SUv4eiaS62W95KpFztmmvUramflq18JMT5nAisN
 g=
X-Google-Smtp-Source: AGHT+IGvRNY8OX5rHcpsqCzIQrqqSWvt5b3CAEi+NWtcSTePibAofXHOOYMMxVpEqYO6JYm2Rnfj8Q==
X-Received: by 2002:a5d:584c:0:b0:3c8:29eb:732e with SMTP id
 ffacd0b85a97d-3e6441e514cmr7655448f8f.59.1757361559435; 
 Mon, 08 Sep 2025 12:59:19 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45dda202112sm158767245e9.5.2025.09.08.12.59.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Sep 2025 12:59:19 -0700 (PDT)
Date: Mon, 8 Sep 2025 12:59:13 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Thierry Herbelot <thierry.herbelot@6wind.com>
Cc: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>, Devendra Singh
 Rawat <dsinghrawat@marvell.com>, Alok Prasad <palok@marvell.com>, Jerin
 Jacob <jerinj@marvell.com>, Olivier Matz <olivier.matz@6wind.com>, Edwin
 Brossette <edwin.brossette@6wind.com>, stable@dpdk.org
Subject: Re: [V2] net/qede: reduce the optimization level for gcc > 11
Message-ID: <20250908125913.7deb6fe6@hermes.local>
In-Reply-To: <20250908070414.1297844-1-thierry.herbelot@6wind.com>
References: <20250903113252.2496087-1-thierry.herbelot@6wind.com>
 <20250908070414.1297844-1-thierry.herbelot@6wind.com>
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

On Mon,  8 Sep 2025 09:04:13 +0200
Thierry Herbelot <thierry.herbelot@6wind.com> wrote:

> +# no packet Rx with gcc > 11 with compiling with default -O3 or -O2
> +if (cc.get_id() == 'gcc' and cc.version().version_compare('>11.0'))
> +    base_cflags += '-O1'
> +endif

Did you test with Gcc 14 and 15, it may be the bug is already fixed.
