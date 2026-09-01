Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF53C624A4
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Sep 2026 02:55:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36BE840299;
	Tue,  1 Sep 2026 04:55:28 +0200 (CEST)
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com
 [209.85.215.173])
 by mails.dpdk.org (Postfix) with ESMTP id 7307B4027F
 for <dev@dpdk.org>; Tue,  1 Sep 2026 04:55:27 +0200 (CEST)
Received: by mail-pg1-f173.google.com with SMTP id
 41be03b00d2f7-cc1c3d79b9bso3727191a12.3
 for <dev@dpdk.org>; Mon, 31 Aug 2026 19:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1788231326;
 x=1788836126; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ly9UzDqo2qO/2PsRk1LNUkkqcrlc7zJPLf8eucDzpfg=;
 b=zsT18zqbKz4j3wWUsxqTiLSMleqSfD4qGEKPOhiWxklEOFrisABk8mn6bO4GTn0gBJ
 f+Msccis6PIjr/S71TMz6kRnG8B8T/b+ZJY8NrhHMQ9za58+fuNzOypCPvFBbRzNBeW7
 XFSb2wM0SVPB8oOKlRK0PkKTUoGsrJ8BaAiVFCnIp6kspD4EYdZU42hRQHFhUudcugjS
 WRviCMknOpZwbBTNYSmuh1jbkZ4qri6KINVQANe0fu62zMUFD1ONfVNu3VyIECI6sWAb
 9P2F2LWYKsyPZRbEUvqj6JwDVNQi64VFeTozZR1wJOZOizP0hS3nUQNQP7fl0TjzrEto
 d6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788231326; x=1788836126;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ly9UzDqo2qO/2PsRk1LNUkkqcrlc7zJPLf8eucDzpfg=;
 b=RD63XvXtbziv/U7pM8hSKXezqeXWmsZqIXsyi0n7MYWdJUHmLrwqzmGQQV2fJ6rMKO
 1l49uN1ygDykXkgI7g9ixrEMzntjhbQcKcrwqwXg+VqmRqR+yTcSKAoW4FUyYPFzgxay
 FcN+BRajTGgJPsM5EfDhwlAexxp4kl+kYVu5iROFQg+sdK+oZNTTKtwyx/AbJk3LjV7q
 J0Oh8OfQdALM/l/9M819Mgtuv7z0Rn1kwiooj6Yj7FX18gnJHKtSyQZWMeleEDb2cgO9
 yFGC6p88UMTFbLQjF+Qcla8HXxkJVU7tp11m3yPu+xHriGpyJgwm9fyV2P59Qkhy74T3
 O9Tw==
X-Gm-Message-State: AFuF++n6OcNEVT1DQZ02wvc1TaORAMTs6zUv/Uv7aNoZk3cAFhoSixyU
 XjjAvRDc2R9Jb8PopuoEVw9AK7eMTmBVTuCocle6I+xvOj1vHTKIJiM3C66p80uvwAQhXaTMsII
 dv8k4
X-Gm-Gg: AR+sD10JZQHDBBKKx8WXWgM3wK4hSQTpsQd5mNyjf+wZFBH7gKADQ61LSPCtnoGab6J
 PJ6AiajA4BSSndVjoL4DdaDOoM422zAGI89ZFUQYM66/sSk3KdNF9szH5msaxd6At22ML7SGN2B
 MXR9hq1qE1/5T0fBy79VM0QShR9t21nB1JG8HgfiK6IERY+B33zNbWPHLpMPZG4MbS/uA8ht1MD
 6BxXPGZGHO6Oho09RJYVelJJss7R92hcj5eaJwiloI90zpOkkY6flW5oQ1BUZS+foomgIZdFAT9
 Emm8fMbIQA5YX0vxiucdKYMNQH6etLqCCVHN9tpEmBUxN24PEf1+THqglRkzq3xWMbcLJvsazBp
 NBnPZ19Zg84yqNuaNJyy1qoxb6pCiAyi+Nzpmc13iJkwsnVVkvx1QzBlscsPXCjkn9pIoOZ4pUr
 lelwk1Rm/7WzrK2W+WTvMoCNGdYZsjVRoHbrhAe4eVdHvNhOrbLb+WzrT/H7ooQtvt7GLIgGsjh
 npmoPA2Jwo0qB6rC55RwWYrwkD9qA==
X-Received: by 2002:a05:6300:8054:b0:3d7:b3c1:cc34 with SMTP id
 adf61e73a8af0-3d7b3c1ccf3mr6041177637.26.1788231326168; 
 Mon, 31 Aug 2026 19:55:26 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1f36dbf62sm5125550a12.25.2026.08.31.19.55.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 19:55:25 -0700 (PDT)
Date: Mon, 31 Aug 2026 19:55:16 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: "Randy Tice (rtice)" <rtice@cisco.com>
Cc: "dev@dpdk.org" <dev@dpdk.org>
Subject: Re: [RFC] mbuf: add configurable base private size for pktmbuf pools
Message-ID: <20260831195516.71a00639@phoenix.local>
In-Reply-To: <PH0PR11MB76163DCD87BB40C437CB54C8A9A92@PH0PR11MB7616.namprd11.prod.outlook.com>
References: <PH0PR11MB76163DCD87BB40C437CB54C8A9A92@PH0PR11MB7616.namprd11.prod.outlook.com>
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

On Mon, 31 Aug 2026 18:20:19 +0000
"Randy Tice (rtice)" <rtice@cisco.com> wrote:

> Hi,
> 
> I would like to get feedback on a proposed mbuf change before sending patches.
> 
> Some deployments need a guaranteed private-data reservation in every packet mbuf, across multiple mbuf pools and across different consumers of the mbuf APIs.
> 
> Today, each pktmbuf pool can request a private size when the pool is created. That works when the application owns all pool creation policy directly. However, not all relevant mbuf pools are necessarily created by application code. Some pools may be created by libraries, drivers, or other components outside direct application control.
> 
> One example already in DPDK is vhost crypto, which creates its own mbuf pool and supplies a private size for struct vhost_crypto_data_req. There are also driver-created pktmbuf-style pools, such as cnxk inline meta pools and TAP GSO context pools. These are examples of pool-creation paths where the application may not directly control the private-size value used at creation time.
> 
> A PMD-specific devarg could solve one instance of this problem, such as a single driver-created pool, but that seems too narrow if the requirement is not inherently PMD-specific. A deployment with multiple drivers, libraries, or other pool-creation paths outside application control could need the same base private-size adjustment. In that case, configuring the same value independently through component-specific options would be fragile and easy to get wrong.

Would be better to make it a config compile time option.
Then drivers could use static_assert() to check for space.
Doing it at runtime is harder to handle and enforce.
