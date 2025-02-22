Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C302C021B2
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Feb 2025 21:57:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E8C104025E;
	Sat, 22 Feb 2025 22:57:23 +0100 (CET)
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by mails.dpdk.org (Postfix) with ESMTP id 349A8400D6
 for <dev@dpdk.org>; Sat, 22 Feb 2025 22:57:22 +0100 (CET)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-22104c4de96so55992795ad.3
 for <dev@dpdk.org>; Sat, 22 Feb 2025 13:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740261441;
 x=1740866241; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5P823rsyVYCrck+K5LaiczsbiwuiORjjFu2iKWIHeI0=;
 b=laIwVjAedFnZuxx/oWfa0XwGfZOlSpDQyTbWmLQD+REH/8TAMMw3ZykBZYaOj2HQtZ
 T+rdfCfqF7UINuMNvnkuKW1Tv/tLsQIjSqyoDEGq4/T8jX/KsNQTcKw5qMhgN3KVwlZ3
 gnbJBFEZZDFW4CkuL/L7rhOG9eEMoPjfouKpEUeG+0ohd62yaKZnD9aRn7ajBzP8r1EV
 iNHLpDXfUIqZfe07K03VL8yMGqxPc0UwxQXQ3+bvouQpPifbeih6qy5oye4PRx+oErJi
 mIPuKszveFCFyv12kwv2qZtb55R4OuzHPsNmfueK/yMoxWmB+eYMwS1HrmJKEpboh7+n
 yWSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740261441; x=1740866241;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5P823rsyVYCrck+K5LaiczsbiwuiORjjFu2iKWIHeI0=;
 b=T40PpgHyXK2DzJisw2Lq4/ATHxspfdodm/d/Ii6DO5ypf9Cbl0PiFqJtlM3JSD/0bJ
 8Wk2Djm8PeGLceFZn9LI89LPDQ1OLda4bw2y9spavTixbW+lFiNoLpcWntUhHfL7KMrC
 f/EE7GQgTaVd9B4M0uimsuIQz3mbqNiDYqsvDzQed5DUJcLppMP7HG1GufoMB2hVzrE4
 nFbKxvfXVwncfsogmrOIMLqTUAf7KJ3O/OtitWDV9uMhf8PBkghlb3CdZwqs+T0hTO8A
 2C7IU3pSoVJc5AbnMzlyLgHLQ+rakjI88LLDF4dLueFgeeXO/EFnhgurbHk7omxvYstU
 ryqw==
X-Gm-Message-State: AOJu0YzKp21WiB2ePpZD2CUl9L13RxABLj0XoSPifVcPAtjzfSB5DzWd
 sUwAMiLL9gFaU3SSHPm1jK4T3WD2G4oJtlJNxHQ27+AgIWD6UXzElmg3bkGN0+U=
X-Gm-Gg: ASbGncuhBofHOxZJHxytldhFO5jij0rF4twaUdrGYYumJ2ueAkhAZicfeyeBIvfOR8+
 8bOXgTGJFtaMB7uTmqobAOVSy3Asy+4nG7gDAmDs3xS7cHAXART7QhlHHhwrCcfu1n54Newtd0t
 cDft0S4vOKcu1QTaNp2bKRHPgGg92x65/hUOS1HUZCAQvIL7VsGKMM3Qiok62vCL72MwKGXhCmG
 xU44ykINIxC5EmSMFOQciuTz6Bm2PFMc9K5UTRqbrHdw2aEumyBileuTZKXEJ/94MPg9Z4PkhRW
 I8X6BjxrW4lbU1RNPZ1l3IqXlPO9W0ilOYqoVcRgogHOZqGCv3K5n2OvWa5UW8Fx3xpRX0kpU3W
 dG4g=
X-Google-Smtp-Source: AGHT+IGcwkcEfvAZ/eB64ZashD/dDi/WSmU5YB2nr/M4B32tQG6LhAH1aYmcSz8+Y2Piuujbkvgy+g==
X-Received: by 2002:a05:6a00:1812:b0:732:6223:552 with SMTP id
 d2e1a72fcca58-73426c9006amr11744563b3a.1.1740261441123; 
 Sat, 22 Feb 2025 13:57:21 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7326bcd94fdsm13922499b3a.53.2025.02.22.13.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Feb 2025 13:57:20 -0800 (PST)
Date: Sat, 22 Feb 2025 11:21:23 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Serhii Iliushyk <sil-plv@napatech.com>
Cc: dev@dpdk.org, mko-plv@napatech.com, ckm@napatech.com, Danylo Vodopianov
 <dvo-plv@napatech.com>
Subject: Re: [PATCH v1 25/32] net/ntnic: add SPI v3 support for FPGA
Message-ID: <20250222112123.17600a98@hermes.local>
In-Reply-To: <20250220220406.3925597-26-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
 <20250220220406.3925597-26-sil-plv@napatech.com>
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

On Thu, 20 Feb 2025 23:03:49 +0100
Serhii Iliushyk <sil-plv@napatech.com> wrote:

> +/*
> + * Send Tx data using the SPIM module and receive any data using the SPIS module.
> + * The data are sent and received being wrapped into a SPI v3 container.
> + */
> +int nthw_spi_v3_transfer(nthw_spi_v3_t *p, uint16_t opcode, struct tx_rx_buf *tx_buf,
> +	struct tx_rx_buf *rx_buf)
> +{
> +	const uint16_t max_payload_rx_size = rx_buf->size;
> +	int result = 0;
> +
> +#pragma pack(push, 1)
> +	union {
> +		uint32_t raw;
> +
> +		struct {
> +			uint16_t opcode;
> +			uint16_t size;
> +		};
> +	} spi_tx_hdr;
> +
> +	union {
> +		uint32_t raw;
> +
> +		struct {
> +			uint16_t error_code;
> +			uint16_t size;
> +		};
> +	} spi_rx_hdr;
> +
> +#pragma pack(pop)

Use of pragma's is strongly discouraged. For packed data use __rte_packed_begin, __rte_packed_end.
Not sure why packing is needed here at all. The union will result in the same
