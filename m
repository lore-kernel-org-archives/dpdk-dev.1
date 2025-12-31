Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6B9EE645E
	for <dpdk-dev@archiver.kernel.org>; Wed, 31 Dec 2025 19:28:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 101C1402A3;
	Wed, 31 Dec 2025 20:28:11 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id F17D9402A0
 for <dev@dpdk.org>; Wed, 31 Dec 2025 20:28:08 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4779adb38d3so72206665e9.2
 for <dev@dpdk.org>; Wed, 31 Dec 2025 11:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767209288;
 x=1767814088; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v/dsyssTfxwN5FJsBqmeF6aJ02Ac/TlDr+dZM5+bHig=;
 b=Cc8UfYKKBtlAhF3CyImAyWQotEsasSvG61Wi5wQo0QDLCbRVUrIJZpH5PuR07Ugjd4
 09GywWe031kyEBmwseruQ4KsSGVcB7KJaiDAmovEBiuJCGPZH3/+lC/uK+jl710idd1Z
 KugdN/J9qOZQYQRk8E+gYAQYIh6D0tpEdvkLOlMvQKqkPkNeGDvcT11usnJRDb59sZIC
 mPUtaAilzyQt2/428e/jtEBLo5pOyKiHVAEAqnrR4pkcdlAck/udrATnvld76G4dNG32
 MNH5ZcL+6NEGL8FFZTxPQi/QJsktFVKs7uzD7upIlAJaevyf0TZ5JHkN1VrDvGF4FLQF
 GbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767209288; x=1767814088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=v/dsyssTfxwN5FJsBqmeF6aJ02Ac/TlDr+dZM5+bHig=;
 b=mklHxZyU9zEaMNOnRIaIzUlpGYDWKFLvO6FT5GliTF9K9X0/2ULMd16hqwPWn8t0uc
 LHnIcE6LFJW5FAcu94Bt6fbMyZjSTMAJ1fTWOxtY+VC0f04Kh2fSxzK3C8k24IIW72UJ
 94NnZdjTHAfkDDnCXD19QGpqbD8hC6xGytZncpiQWMSEKaeRYIkqyy2+CinN7Z6JZpVH
 Em4Dr5RBpHyals2C4X0O1M/mkG/xYr81j52lkT3ro2T637qiSPk80CEGrF8pLLaddxvM
 IaBLbuTp1Wpmlf4TBnag1oTvoWy34PEyepZf+Ik500y9bxUDkTrPVQTobLNegS+mCciz
 LOig==
X-Gm-Message-State: AOJu0YzDCl6U1agQplRa3r7G3boXFQko3qRGSlk60AF9FnS0mUyu+Sw4
 6PefSY54Sbd/ly7lJVIGYv/4SVk5Ob54mfOJsdjRF5hAHUamWlGRA46K6vUMma8YHlQ=
X-Gm-Gg: AY/fxX6teqw1z1phZXKM0U504DdA6chewecmg6SrOuJF4Xk2MpqJ8IfsOblxVxFfsgW
 fdIOe5Ww6UkyZ3uDAtfRna4IBo2YxiM08uFvsRN1Od+kAeK5QQXMP9jOtbCsTvqwSN1PF54Z+Ul
 R6JvaRG3OWP4mFhUGh7GJ3NYcas0+ZM/ekSBba/dxgqjumc8lPBdNP7kcuV5Fcqlqq3KrAkTcqO
 OXimaSKWWyK5qz8/9yXWW5/URuxzILJqY0ZnpGUyfPplg6eW+X1jncaPChFoYtwdR34Fy6D9ACW
 BKdMo30LevlqzwSZp5/jgT/PllTIJX09qDWol1T6K2BEzloZ80OWqkooms1PnaaTsdDo0dLaVSH
 dBQTef1qpcKnDye3polF0OBPubF1MYAiHzKP9gAMnkvoxGxyRTJIethzJeqFxmdt8PvaMhmCgwF
 wsfIDUIvnu+poJX+qlnHsDWTFhrbMa8QJZnvDcBkSd/1sK0kVCOPWv
X-Google-Smtp-Source: AGHT+IHfTHOhLYMsLxpaXN/2Nkod8FMw8S3gtSTDsdaIWxUnfuxP137rWvELHlzqW+5122YglRbK7Q==
X-Received: by 2002:a05:600c:8b13:b0:477:73e9:dc17 with SMTP id
 5b1f17b1804b1-47d2d2a68f3mr353601355e9.35.1767209288477; 
 Wed, 31 Dec 2025 11:28:08 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d1936d220sm728037815e9.8.2025.12.31.11.28.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Dec 2025 11:28:08 -0800 (PST)
Date: Wed, 31 Dec 2025 11:27:50 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Junlong Wang <wang.junlong1@zte.com.cn>
Cc: dev@dpdk.org
Subject: Re: [PATCH v1 3/5] net/zxdh: add support set link speed get autoneg
 stats
Message-ID: <20251231112750.6afefaba@phoenix.local>
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

> +static int
> +vf_recv_bar_msg(void *payload, uint16_t len __rte_unused, void *reps_buffer,
> +	uint16_t *reps_len, void *eth_dev __rte_unused)
> +{
> +	struct zxdh_msg_info *msg_payload = (struct zxdh_msg_info *)payload;
> +	uint16_t pcieid = msg_payload->msg_to_vf.pcieid;
> +	uint16_t opcode = msg_payload->msg_to_vf.opcode;
> +	struct rte_eth_dev *dev = (struct rte_eth_dev *)eth_dev;

eth_dev is used, remove the __rte_unused attribute.

> +	struct zxdh_ifc_msg_reply_body_bits *reply_body;
> +	reply_body = (struct zxdh_ifc_msg_reply_body_bits *)
> +		ZXDH_ADDR_OF(msg_reply_body, reps_buffer, flag);
> +	int32_t ret = 0;
> +
> +	if (dev == NULL) {
> +		PMD_DRV_LOG(ERR, "param invalid, dev is NULL");
> +		ret = -2;
> +		return ret;
> +	}

Since there is a len in the message, why not validate that len == sizeof(*msg_payload)
to avoid dereferencing outside of message.


> +
> +	switch (opcode) {
> +	case ZXDH_SET_VF_LINK_STATE:
> +		PMD_DRV_LOG(DEBUG, "PF(pcieid:%d ) set VF's link state", pcieid);
> +		vf_recv_link_state_msg(dev, &msg_payload->data, reps_buffer, reps_len);
> +		reply_body->flag[0] = ZXDH_REPS_SUCC;
> +		break;
> +	default:
> +		ZXDH_SET(msg_reply_body, reps_buffer, flag, ZXDH_REPS_INVALID);
> +		PMD_DRV_LOG(ERR, "[VF GET MSG FROM PF]--unknown msg opcode:%d", opcode);
> +		ret = -1;
> +		break;
> +	}
> +	return ret;
> +}
> +
