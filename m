Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A32C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 16:23:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 048C040E34;
	Mon,  9 Jun 2025 18:23:15 +0200 (CEST)
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com
 [209.85.219.49]) by mails.dpdk.org (Postfix) with ESMTP id 1ABC54064F
 for <dev@dpdk.org>; Mon,  9 Jun 2025 18:23:14 +0200 (CEST)
Received: by mail-qv1-f49.google.com with SMTP id
 6a1803df08f44-6fadb9a0325so46783436d6.2
 for <dev@dpdk.org>; Mon, 09 Jun 2025 09:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749486193;
 x=1750090993; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lypWncl/SCVoaaIf9o5vWFllXCnILr+kz9pOBu9HcY8=;
 b=eph+ZOhwXwTeNKhgohG4nm0ovcwSChXbm+fhDRjwwQkhQKfVUT3hS6FnhCl9GdzSrK
 BLinwq1Ph9Pb2yhgfGTeB3IisAFZ3778byMOEv/VbG+WGUY77+Ijv0QXJ78Db72Bxo4D
 rqHZm6fbAHAtUHIde0y8Ee+umpO9qtp030t0nDKy3/FZXsHuhRHjgdhYNq+0S71Xb/sW
 nnaG9JYA2xPB3qg8ioVHu5xs5LEVrP27AP4s1/7NOMffQ2hXzVlixTGP/+k8KwTUWELE
 TtrpTJlrUpEsqAt0WXp7KUaE8N/ABci3ISJ6G5/n+aE/quWv7eQMki1z0tEesqgTu+JX
 4lJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749486193; x=1750090993;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lypWncl/SCVoaaIf9o5vWFllXCnILr+kz9pOBu9HcY8=;
 b=E1DO8teDGVpPXQl2aL5lyg6NsJVIa+9aDu0ZqBree867gj9cBL1Ubb31Si7GAGh67y
 zZ4ixWWdtRxajUvP0I/wZNw3nE/odOrrgyKpmomZWdj6Eu6ppN/5mxHZox+qTBoMvdEw
 OqruQVnRAp6t+iSOFrPwCNJRdbyJ+Pft3spxUzkNOg4LKEgv7uMJioj4bch6eaVkQJrT
 6b/ZI9B4o6pozJgl7LRcOUBpyK3/bhlZujRzYuHm68BwZK9QXFmjHSmn8H4RyVCUGbcA
 wlMG/rg/TsgDoZhx1Nb3iukLTMZI/CnCkI9n10bk135TnvpUyn1z7Bd82OHRWJASeIBj
 m8cQ==
X-Gm-Message-State: AOJu0Ywu/LK6LnLiX+u14AIA9t8veGH/BFNEwPe3qKCJnd03Vix3J2gY
 lxrxWDe3P6ukNU8GlT0hxXR2c1rOGIs6M0/ewpMEWcijtxopOPn4Iovo7xkEAHN5T2M=
X-Gm-Gg: ASbGncsqS2v+GzBhPHH3h2jqWrJFGn4xtqBMQYwb0Lg8eXYV7OIJ2hQsXmkMjk4aOOr
 gcZZD57nXaranj+AqJCKr92QinhYe6GTfJmvnUF+bH4n42cVg+9dAvXPYPUiwQthXWg9jrnDv8L
 m2bd+IBAV5xk9sTsxV8boXOt3p9I0btBu2PKLdJr5P+eWSa7BsCWwa3DomSmFHYM3yLEBT48fgI
 h8u65wAynmwrkAw7GwH46Eyx++E2vbPkpvCWaEhTfJ+3P4JTA78XJGI9Zz7gYjKIag2rIsLja9j
 48k2ASbntltw9cQbeb+JitH9aTBunD4ZdWX+cRS4ix+Ev/5HGNeyYIW3gNhw2BAap1uzyWjV0fp
 qzeJaNjZ/+Vhq/jzVMqhyv19UZtkcM9R9v+oUIRI=
X-Google-Smtp-Source: AGHT+IHVHvpy4gL+NxnqPHaaXXQ8G1YfpjiDI1J6IDz3CMzhMxI5I+QQf1SFJDpBRRvTU4aFjMeflQ==
X-Received: by 2002:a05:6214:2249:b0:6fa:c022:d5af with SMTP id
 6a1803df08f44-6fb08f4f43cmr226417446d6.2.1749486193262; 
 Mon, 09 Jun 2025 09:23:13 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09ac957dsm53674786d6.38.2025.06.09.09.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Jun 2025 09:23:13 -0700 (PDT)
Date: Mon, 9 Jun 2025 09:23:10 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>, Vitaly
 Lifshits <vitaly.lifshits@intel.com>
Subject: Re: [PATCH v1 1/2] net/e1000: better clock synchronization workaround
Message-ID: <20250609092310.0d19c68c@hermes.local>
In-Reply-To: <1a8eb4a20513e1856bba0d6df25ce378aa8d7fae.1749464159.git.anatoly.burakov@intel.com>
References: <cover.1749464159.git.anatoly.burakov@intel.com>
 <1a8eb4a20513e1856bba0d6df25ce378aa8d7fae.1749464159.git.anatoly.burakov@intel.com>
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

On Mon,  9 Jun 2025 11:16:41 +0100
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> +	ret_val = hw->phy.ops.write_reg_locked(hw, E1000_PHY_TIMEOUTS_REG,
> +					       phy_timeout);
> +
> +	return ret_val;

Why use temporary value (ret_val) and not just a return statement?

	return hw->phy.ops.write_reg_locked(hw, E1000_PHY_TIMEOUTS_REG, phy_timeout);
