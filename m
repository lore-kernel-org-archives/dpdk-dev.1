Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED08BE67482
	for <dpdk-dev@archiver.kernel.org>; Sun, 21 Dec 2025 16:58:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9E6D40276;
	Sun, 21 Dec 2025 17:58:02 +0100 (CET)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54]) by mails.dpdk.org (Postfix) with ESMTP id 2DAEE40265
 for <dev@dpdk.org>; Sun, 21 Dec 2025 17:57:59 +0100 (CET)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so29642005e9.1
 for <dev@dpdk.org>; Sun, 21 Dec 2025 08:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1766336278;
 x=1766941078; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B9WBf0By6dz2l8UsvHbhVwLCB14MGNz5wl0Mf2+7t7I=;
 b=2kLeFqzQGdEnx+96dKl3T4zOyhfRNwpanxlazXKZtu2J4GaoOGnXOU73XXjXP8s4oD
 /YdWWgHe6kPcC9XBkuquAU/4pUqOAZ2n3I/SpDQ2PKcgf2kd2ffURRc3QijIF+eIB6Zl
 PgqwLOeqColx/D/hTlYxwk+ipcMDt1BCOlvgsP2ydoq86Ugn1DFQhdzZOp3gA3dDTwBj
 F05JmWwEOf00kGRUXuKXxIJfgxOhthEATUaBQ1QeD446dYBfYRHmjSfIN9RuojWpeAt2
 HrUoEs9IbwNuoBVCn4IOFpSU2Z2IfyEN0cJQ7b0iA6j6NNPceZ19AHBIKOkzikNvPsPH
 k1Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766336279; x=1766941079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=B9WBf0By6dz2l8UsvHbhVwLCB14MGNz5wl0Mf2+7t7I=;
 b=el1yDfXq20A8Gkr1yHoYq3NpWTP11vjCiPwNGnkuYo3/eT0Bqm8RDYtR/fc3sNhtTP
 cQjf47I9LuoOXVV7lcFZsge/objYRJ1xvWlk59zDDQpRtggtPYpYmfnYSf6isiPF7nId
 DmL5mYeyPrWijhl8AlyavTZyJEet0lvhXfHx3Id9OhUpl18evW8Rre/u40is1n2YccJw
 p33ETBQSpVFlwLZzZuh5Alyy1Enr0FPpvlVD+aRD6gCGy8rHo9CJjEGJMrJq4OslYmc4
 uUtntDsdIsCQLXJKKqsnARW+r0tJylxrjtA6kYjL+b7ZxIclF+YQZguK6P9BJvsfdoKe
 vUUg==
X-Gm-Message-State: AOJu0YyXqo39TpQ4zm9XOOdhLsaNjuyvQfe86uWA9c+zcznfTiudH/cz
 bfRayjAeId7cWgdJadPed1IpxzqTNO1RUb445fLubmtO2jUV/pqcqM7xF0y9uF2fes/+NsJChHz
 kseaigGc=
X-Gm-Gg: AY/fxX6KLnFBJNQOXcm1pVewrsi99W/u7+CQrZgfhXNoWl+7QUyDUU9h6W6OKlGeZbb
 WMYHdTtSMO/LbBDc6Qoh32HF1wTzLGox8fKN3NJBuGi7LBGPslmtHd96/oejQ0TrW6brPVwV7Ip
 GfirrbtWoTFmB7mqPBswPD000g8kuNu72lns1fX8Srq7F/pNOLEhLDGma78v5hc0Ksz6ksK035B
 ksFuoo8flEE5rrueHPvPaatuCZ9oZgOzxV5V+CAwEV31Vjyfz0W0j6o04sNriCDqV72EKeb0MrD
 1FkWCVF7Nhko0KkkALZ99/1u0S0VfJLVdzbkaq70yvBgVIsjGu84vAFEirRNHQPQHckiaWc4zJg
 8/Xf6dUye7CWRDg8iR/FmM8Sy72O52pk+5eNqcy/WrYQebU4Fm7AuNnCO7FvtxdQ5lwKi1XNEID
 QrrlsVQvrhkd6yla+S8gwq6Nzy127qEKkTdKz7LhAuS8L8jnTXZC0Y
X-Google-Smtp-Source: AGHT+IGtkYdlU0zZuXzNjpeEaKruw6CmXwj+Di93egGA0zAbMnmUbxu/nXcR1XbYmHoo4x/9mTdyRQ==
X-Received: by 2002:a5d:5d0e:0:b0:430:f58d:40df with SMTP id
 ffacd0b85a97d-4324e4c7132mr10088179f8f.10.1766336278480; 
 Sun, 21 Dec 2025 08:57:58 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324eab33f5sm17379862f8f.41.2025.12.21.08.57.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Dec 2025 08:57:58 -0800 (PST)
Date: Sun, 21 Dec 2025 08:57:53 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 3/5] net/zxdh: add support set link speed get autoneg
 stats
Message-ID: <20251221085753.5a451f64@phoenix.local>
In-Reply-To: <20251220061521.289722-4-wang.junlong1@zte.com.cn>
References: <20251220061521.289722-1-wang.junlong1@zte.com.cn>
 <20251220061521.289722-4-wang.junlong1@zte.com.cn>
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

On Sat, 20 Dec 2025 14:15:19 +0800
Junlong Wang <wang.junlong1@zte.com.cn> wrote:

> +int32_t zxdh_link_speed_set(struct rte_eth_dev *dev)
> +{
> +	struct zxdh_hw *hw = dev->data->dev_private;
> +	struct zxdh_msg_info msg = {0};
> +	uint8_t zxdh_msg_reply_info[ZXDH_ST_SZ_BYTES(msg_reply_info)] = {0};
> +	void *reply_body_addr = ZXDH_ADDR_OF(msg_reply_info, zxdh_msg_reply_info, reply_body);
> +	uint32_t link_speed = 0;
> +	int32_t spm_speed_modes = 0;
> +	int32_t ret = 0;
> +
> +	spm_speed_modes =
> +		zxdh_speed_mode_to_spm(dev->data->dev_conf.link_speeds & ~RTE_ETH_LINK_SPEED_FIXED);
> +	if (spm_speed_modes == -1 || spm_speed_modes == hw->speed_mode) {

Avoid unnecessary initialization. This driver seems to do this a lot.
The extra initialization defeats many of the compiler checks for use of uninitialized variables.
