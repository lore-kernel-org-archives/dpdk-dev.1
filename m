Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7706CCFA13
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 19:03:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB35040648;
	Wed, 29 Apr 2026 21:03:53 +0200 (CEST)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176]) by mails.dpdk.org (Postfix) with ESMTP id AA999402AC
 for <dev@dpdk.org>; Wed, 29 Apr 2026 21:03:52 +0200 (CEST)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-2bdcf5970cdso191564eec.0
 for <dev@dpdk.org>; Wed, 29 Apr 2026 12:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777489432;
 x=1778094232; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r9y31zDNrdGQ9IEkBScCo2o9J82+dHCHp6MiEIgLkfs=;
 b=TEkrU1UIVMnK5Zioh/D97wpncyEi965jtwXDMpN+UmjeJKL3ZmC23gRI8KKtErnhgf
 9s/NH754y3oVAIchjdU6c6VjaY/7eCtnDDdVF2YoJbyIVk9TZdlKqRFgeq7TcAF3OCVu
 BSsezrnNmOqRTTKZqZA7xfE4UyChovspbJfBkl0m/egy9710NGZgqRpf9n2nRInOxFo0
 OVmtmD5n8MlQyT2oXO5922DM8HdFm+eRbdfR+TUYhFDZrdu436JhWA8GvM0otYsipITd
 +SlqB+A0PnoQI4vL/fw9cfcw7NNlZnVaE6AKGRQsSNWnd6ESv4q4HJrrzZqEUAJBEeEg
 86xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777489432; x=1778094232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r9y31zDNrdGQ9IEkBScCo2o9J82+dHCHp6MiEIgLkfs=;
 b=WSsymlFUe07qcOuu1LnocNm00jh4B2Sz1Rh6SZHojvOX54ey8edLqcUf2WBICr54J5
 x1YoT/PrQpGsy52AmZ5WIneoAKGaqKBBu2ayG7OFKlO3fwck8kq4KSP+g1UE/eqHk5Rv
 C6jQ4yjtslDB6FHyOEuNx09WRFrRlltvAPVU3FsWFSwooEOpBvK0wcQWnsAGjI8D+Ly2
 i1GlSzUtQYz75tjWTWaj92D94ef9A6oANqD1fjBYZ/Z1O2GzEoHNsYjbqNdxbsmKQxt/
 Juacss54o12IB54e7P+YkQv2XkxrYH9QlyKHivvOfv9Ag9Yp6LH8+WjW49JvtXED/9OR
 cC3g==
X-Gm-Message-State: AOJu0YyJ4W7SsQzTC9MDN5q7hE73CLarEt5CA/SEElMX7o9Bi0wiA2Yr
 tuBr2Q0OYcOwajdRx970BxVSj18dXQXWqbGDNwWAhIL54FJFKu6iAfgix4fFrIyP/5U=
X-Gm-Gg: AeBDieuOfpmoLYT42U/LX9FhyjQzrgOWM4cj/lFxYHuq2aCSsqthka0b0fBJYjBUrBq
 xGRXe1ZtqHx8YyT1HskgjwOx1VmUvpMlG3d2R4P+R7/MDf3dYytMPRYvEZ8wMm+IgicwlyIx9pb
 u2bib9IzMyqiTW6IWrmHMBIUqHveDqw0KHz34yakNmOIp1yISWy5e6+RFcGFdAlvSY7oLgjIzrP
 5mBD+gNz4MQFmerzE4YR+VInqji3Cjisj6g656oXbPo9rjMXRWE/fYZSTJ6eOE5P0FIZrIAkGLu
 U4jV9uHJOEjzz+zVQvzlzewPemB9JkFQZBeQ6H8i2WDVYT4dowvPbTBnkwkGmjmuoUqwridwN37
 xGKCl1FZoP+fB4URW+TJdSXA4lQwDkK6XK7DWz9esT19GAk3VcNxAMJRWmYl+DWrFJyDuadFonn
 pJ0Dxg4F0Wot6QZZd5bADF9aiVjvcSsdJWZ95akaCKVyasTQ==
X-Received: by 2002:a05:7300:a897:b0:2a4:701a:b9ba with SMTP id
 5a478bee46e88-2ed1b4214dbmr1896024eec.14.1777489431407; 
 Wed, 29 Apr 2026 12:03:51 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ed1bf8e268sm3369104eec.12.2026.04.29.12.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 12:03:50 -0700 (PDT)
Date: Wed, 29 Apr 2026 12:03:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, techboard@dpdk.org
Subject: Re: [RFC PATCH 01/44] eal: define new functionally distinct config
 structs
Message-ID: <20260429120348.38d59538@phoenix.local>
In-Reply-To: <20260429165845.2136843-2-bruce.richardson@intel.com>
References: <20260429165845.2136843-1-bruce.richardson@intel.com>
 <20260429165845.2136843-2-bruce.richardson@intel.com>
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

On Wed, 29 Apr 2026 17:57:53 +0100
Bruce Richardson <bruce.richardson@intel.com> wrote:

> +/**
> + * User-provided EAL initialization configuration.
> + * Immutable after initialization, so no need for atomic types or locks.
> + */
> +struct eal_user_cfg {
> +	uint8_t reserved;
> +};
> +

I assume reserved is only placeholder to be clobbered in later patches.
Internal structures should not have reserved fields
