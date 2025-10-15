Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A53F1CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 22:10:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F3D540A70;
	Thu, 16 Oct 2025 00:10:41 +0200 (CEST)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id 226E140DD8
 for <dev@dpdk.org>; Thu, 16 Oct 2025 00:10:40 +0200 (CEST)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-856cbf74c4aso13512085a.2
 for <dev@dpdk.org>; Wed, 15 Oct 2025 15:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760566239;
 x=1761171039; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XMvYieWdejvYeJVyjZZyviodkeL963G3maCX2sdSNi8=;
 b=FFO92aRT+NxaSD0KO9wKJgZvJMvcaSjtkq0SdJYMip9wkAATcxa0Hsap3Sab9hKxGg
 8t/O6JjksWLVgkaqoEuHEI34RtDedKuqaM7LrfG8+LaDnb3MTu3XPUt3LzfuCnNlITtE
 J2tSS1BB/lMZvQ1ch4/kM0bvp68ITS0paLkKEuAh2vcrcHTIPkyDSfCmCuOC+sh0mfPJ
 ah8UFHMQhgHr9TmgFow6FMt0Zbu6h0M+F6Uu77rqggFtwuDif+LrCjiRB26x+rDnjKQO
 UoFit8nq96eL7S0DERSv4G/fUtgEE3nxlf+EKkDCGzHAjAYJ1In7JdkpSZ4a0mdXxAv5
 R5TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760566239; x=1761171039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XMvYieWdejvYeJVyjZZyviodkeL963G3maCX2sdSNi8=;
 b=j9vsqZV/VUlO94/KFFX13SX48riqB/nT8alSZsMnKSBC6ud8GDhwKvysZtrdjxfiFS
 ruE8KxGi0/S8OwXX2gLFo4yFtja7fF18QHskM0A12rtcu/Kwxjp2rjmHSqgQ+CN8iVjb
 Fa0dKnv6fZIunQOE1uxwrGcyFQpKfUJ6jVMGwmPLMi1PuQrMErLsbEfOu9N9xwaSV26l
 T+JFHCzTPp0vQl4oGxhXbRcinK1WLaW9V8i6F5DxNeFIII7yg47debs+nmDbKOCGJsF5
 K5k24DPPRPFgE+ui2SmYOpmGSZXDtTvq7gsxfZSSaGFi9gc7tECiAcChzORgSfaTMXYc
 lQ5A==
X-Gm-Message-State: AOJu0YxGAxtTjKxmWZzm5OlZJM7VlRAOPbbQyKQLmvbhj+ky62gyK0gU
 tvpr3l3BcRr6W/9b1baBbHOsCImzh6R1Oc6uAKjxfyt9dKW4eQeLbPf4tRejzIX3e+Q=
X-Gm-Gg: ASbGnctVJD6MJdZq+u/NbpBMv7dbV0xtaFrBPYWyRaqZMUNL8g2VHWMLWFdX3z5HRtR
 wOo9HKJW+Lg99g/NVl9dHh7Q7xaGhLU+CTxs8YaeWMA9Ll8ne1fGaHX5hDlj5ijEpddXvb3RK9W
 LhxLufeyvfKimmUGjd66SUEJ30f9V+I1XAS3rnRSeB8R+SUz+Ip129JL+qmQDjnJx6MulXLuwxQ
 r2uEJz6Q5cp3bnnbAQw3Yagr5t3k0FQrctAWWnuN5xZBkh0Df1TQNImOlSVv6+tFZ0uGutUZmWZ
 /ENQkIP9ieIKHqCRuuRy/XO1QZN9kvN1Vbnyi3c0CS+KjlbL3cfIxqzfY6eqAHl1y/ehgpmPtMV
 b+KpqRo9q2F7j3Dd7UlcHegIV7Uq3X+AM63f9YBDHcUqmgaP/AAZSjG9FWUKNvsa0OJOfPI+Kh/
 ddjy6F759DtLM/UowIRatU+DT5h0qpdJE+llLE5n6eIi1ZXZK5vHQ22dBkr/gP8Do=
X-Google-Smtp-Source: AGHT+IHQzXIhNzqOrS6DqOfsqXTeERt8n7zP9a1UdwEl7Cw+eQSQtybOOcckAcpr4G75yg04C/sjFg==
X-Received: by 2002:ac8:5755:0:b0:4e7:2b6a:643a with SMTP id
 d75a77b69052e-4e72b6a671cmr149853611cf.12.1760566239349; 
 Wed, 15 Oct 2025 15:10:39 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e881c577e6sm27732021cf.7.2025.10.15.15.10.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Oct 2025 15:10:39 -0700 (PDT)
Date: Wed, 15 Oct 2025 14:50:21 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: vanshika.shukla@nxp.com
Cc: dev@dpdk.org, Gagandeep Singh <g.singh@nxp.com>, Sachin Saxena
 <sachin.saxena@nxp.com>, Apeksha Gupta <apeksha.gupta@nxp.com>
Subject: Re: [v1 02/12] net/enetc: Add RX and TX queue APIs for ENETC4 PMD
Message-ID: <20251015145021.3e0f7279@hermes.local>
In-Reply-To: <20251009111633.3585957-3-vanshika.shukla@nxp.com>
References: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
 <20251009111633.3585957-3-vanshika.shukla@nxp.com>
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

On Thu,  9 Oct 2025 16:46:23 +0530
vanshika.shukla@nxp.com wrote:

> From: Apeksha Gupta <apeksha.gupta@nxp.com>
> 
> Introduces queue setup, release, start, and stop
> APIs for ENETC4 RX and TX queues, enabling:
> 
> - Queue configuration and initialization
> - Queue resource management (setup, release)
> - Queue operation control (start, stop)
> 
> Signed-off-by: Apeksha Gupta <apeksha.gupta@nxp.com>
> Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
> ---

It doesn't look like the driver is doing deferred start correctly.
Expect some logic like this from ixgbe to be done from dev_start
handler. There is nothing telling hardware what queues to enable.

	for (i = 0; i < dev->data->nb_tx_queues; i++) {
		txq = dev->data->tx_queues[i];
		if (!txq->tx_deferred_start) {
			ret = ixgbe_dev_tx_queue_start(dev, i);
			if (ret < 0)
				return ret;
		}
	}

	for (i = 0; i < dev->data->nb_rx_queues; i++) {
		rxq = dev->data->rx_queues[i];
		if (!rxq->rx_deferred_start) {
			ret = ixgbe_dev_rx_queue_start(dev, i);
			if (ret < 0)
				return ret;
		}
	}

