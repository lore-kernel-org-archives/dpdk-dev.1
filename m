Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D953CD98F2
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 15:58:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41D6940A6D;
	Wed, 17 Jun 2026 17:58:06 +0200 (CEST)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177]) by mails.dpdk.org (Postfix) with ESMTP id 91CD4406FF
 for <dev@dpdk.org>; Wed, 17 Jun 2026 17:58:04 +0200 (CEST)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-30bd7f4fdffso757745eec.1
 for <dev@dpdk.org>; Wed, 17 Jun 2026 08:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781711884;
 x=1782316684; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=evoAabohPQBn8a7XU8ZQoyJOwciX3Pa5U6sjyYHUm/o=;
 b=zLHvtrMM/XDaAoYL0RPGanXRWXkUpcdG6mco5kExgQfjmS8HFmwvHA+4qQd7+4pdmA
 8c/nl+Kc18Y/EXHCn1bOUADrrJzpnVq3DLEVshbYk02rHSZ0D55mX6QTTqrJ49d+7/Bl
 exUmlKOof47EgoC+nxEaiU1J/No1xjLMfpa0M/HGuDBO0WNXlT046hGDb0xSQE0TTigP
 HjFsc+KjmnmxVlgeHAt1Qbdbo73WXFPxBDOh2xTmni7tcO10Wwvj9Y1vwQ78RPyulpDq
 OVOmitUDXmSZsY5WZhboFKBOoYo6Mc0qxC8NdVpzIGye0Tf9Xa7bOx1gvUjLrXF9TbSV
 AYXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781711884; x=1782316684;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=evoAabohPQBn8a7XU8ZQoyJOwciX3Pa5U6sjyYHUm/o=;
 b=lHaCsyhSqKJV2Walz2fA9ug95lff3/yUiGwS3+jLRm3piNDV4oY5576oLDuTAKIN30
 zEUHpvFEV/xuFnKkRu/Z8RK9Mcd3bUvy1L08ZyEv6LkEj04zWtYEIL7vlfQhdUGR3EMu
 VBihinXX/W3du7oEG9H0kMsKlVbP7wOZ+JNWPOKHiW5Kq6dNP2FgkPW8J/GHl9iUZkde
 mbga2dbTyJZiysIavapmiSk+t3xbocjuKsr2yEzsdzQLn7TQWvfDZ/j06/GgOgBG6FO/
 cK2dhfxZfKPH4N+pNcrvvxNiOSJdjn9UgW4pYsFBvC5wkVhHUg2+PVgLImisLqTMzXuW
 X4bg==
X-Gm-Message-State: AOJu0Ywu2N4KDZvXiyYZTbx0kYSx4s2+ywDKLKo42CGFTtsd+inX3xGP
 GbjcFtk4bn/wzQzh5AO/nAsn5qXhQVQJSnXIPuCeVcts2GW2kket2sjW71K78tfWbGw=
X-Gm-Gg: AfdE7ckU36UdbsUwFvFvBwqOzMfrzSNS5yhOnfWmBZkOC1xJB1Zd7whgb9rFWO1d/y1
 gPwBl8HGi1iQdVxiTfpUE+n0lQk0xdvbyumqfd7fpoqlLujIKztQCmI1cGkvRNGDHCFNsryjc4N
 ulY9DP8I/WNCpsb16IOPyL1GirntOECYv37gHiyN1UAJpeGKuutzU+vCKVwhXUc9RMMPVzcGgIf
 4eti7sCfsAAOhb24V2d3DhGy25swWy9aeKWE8G53Wpx7UJJaDa/w+Bv5qwXrUNONX65kozlFpaD
 mp31Ou5M3cUz5ibQF0J5W40yPqomO1Sz9VS/opjP46W0ZNeBLzuTbhslyWwssnvt4j62k0aBd8a
 4lcazkmVTjC+zrc5XzfriwBxL/6Wxsxqu71466rLwBT6P4hBlNRoZQboiZiut29hS/m2y2SgjVz
 4dvXnZ4D5COFzULxcWaMYiYtpQ69Mu4lzilFyQ3e+DaXeI26biJXLcKg==
X-Received: by 2002:a05:7301:1298:b0:304:cefc:5fd7 with SMTP id
 5a478bee46e88-30bca0edb63mr2081924eec.32.1781711883675; 
 Wed, 17 Jun 2026 08:58:03 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30be0c45a16sm1647648eec.14.2026.06.17.08.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 08:58:03 -0700 (PDT)
Date: Wed, 17 Jun 2026 08:55:22 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zaiyu Wang <zaiyuwang@trustnetic.com>
Cc: dev@dpdk.org, stable@dpdk.org, Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v8 13/21] net/txgbe: fix link stability for 40G NIC
Message-ID: <20260617085522.70d68d53@phoenix.local>
In-Reply-To: <20260617081309.19124-14-zaiyuwang@trustnetic.com>
References: <20260423034024.14404-1-zaiyuwang@trustnetic.com>
 <20260617081309.19124-1-zaiyuwang@trustnetic.com>
 <20260617081309.19124-14-zaiyuwang@trustnetic.com>
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

On Wed, 17 Jun 2026 16:13:00 +0800
Zaiyu Wang <zaiyuwang@trustnetic.com> wrote:

> +	/* CMS Config Master */
> +	addr  = E56G_CMS_ANA_OVRDVAL_7_ADDR;
> +	rdata = rd32_ephy(hw, addr);
> +	((E56G_CMS_ANA_OVRDVAL_7 *)&rdata)->ana_lcpll_lf_vco_swing_ctrl_i = 0xf;
> +	wr32_ephy(hw, addr, rdata);
> +

DPDK has replaced all use of the terms master/slave with alternative words.
This gets flagged by check patch. Please consider other alternatives.


WARNING:TYPO_SPELLING: 'Master' may be misspelled - perhaps 'Primary'?
#210: FILE: drivers/net/txgbe/base/txgbe_e56.c:181:
+	/* CMS Config Master */
 	              ^^^^^^

WARNING:TYPO_SPELLING: 'Master' may be misspelled - perhaps 'Primary'?
#231: FILE: drivers/net/txgbe/base/txgbe_e56.c:202:
+	/* TXS Config Master */
 	              ^^^^^^

WARNING:TYPO_SPELLING: 'master' may be misspelled - perhaps 'primary'?
#267: FILE: drivers/net/txgbe/base/txgbe_e56.c:238:
+	/* RXS Config master */
 	              ^^^^^^

WARNING:TYPO_SPELLING: 'master' may be misspelled - perhaps 'primary'?
#484: FILE: drivers/net/txgbe/base/txgbe_e56.c:455:
+	/* PDIG Config master */
 	               ^^^^^^

