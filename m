Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95344D6CFAC
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 01:14:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81F304021F;
	Fri, 23 Jan 2026 02:14:27 +0100 (CET)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51]) by mails.dpdk.org (Postfix) with ESMTP id 8EAB3400D5
 for <dev@dpdk.org>; Fri, 23 Jan 2026 02:14:26 +0100 (CET)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-430f2ee2f00so1026329f8f.3
 for <dev@dpdk.org>; Thu, 22 Jan 2026 17:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769130866;
 x=1769735666; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ERzMSSwN8obI1Pt6m4Pot0IQkEMML57ggj8ufCm7uHE=;
 b=eJNDhTRPlmC6Mc0IRmOYtSLRvzBQbIUdcaYsMCLz4niEvLYUCjKwxoSvZR0PKuY2T7
 umUqx/cfY+PSqq0Z87MoQS/Q4KULitUVXAeFjjjQhTUoB0XMOgqwjASK4d8xCNjsl+so
 bi9Yct7jejPD114duldU5oL49mEopAaVdWelQJzRLt/At5+H/Vu+n+e9G6gZxjFr4xaS
 1zH35fORKHKmi+mCYmp305LwemyUWO3XkiX/Hz2sykHEtz/UU/VoqaXxxrsU8DaJjjvJ
 E/nwRwXrxGvNz40xxhHjgy2p2ZVHA92kPloP5xk+BL+xTGLMxgTk2qKbMVjdFGY0ODa/
 iRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769130866; x=1769735666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ERzMSSwN8obI1Pt6m4Pot0IQkEMML57ggj8ufCm7uHE=;
 b=Ghzm6pw5kUHjLTMz/8B/4xGF+l4HageHjinLY/7PoLfZbjF0EWPbbMcuwd54kvlr/h
 e1nidquriaGDYh5+7NvMTIa3v7qu57/zs6H6546JpcAdC8aLlDMam+Rmlb0JAdQDsCDJ
 m5g5Egp2SiIkvUh6pzRPqzooJpBY8K5nqU8TWN0KlzLygqKglfoafgiX5vFoNlib9db4
 CRtg9jPlQGcLNgdg0E/ACDXxfD1W8ruP7YQCEDjkI/XhYc4Cfh0qJrUEa/nKMNyhvGPc
 EJBmuMPB2WIrjHKKDHHmnh/s1eISOX2UAr1673uhlngrCMhZMfmheQYs0T9REoDzhsu9
 ofsQ==
X-Gm-Message-State: AOJu0Ywk8+izvn2f763IKHxqSIyjyHbqQqmJ4QqCFUEUzqtp2idOyuvs
 SQrZ/hiIWPSJHpttPnE7YabDpaPlvCEf3dwERK/0Z+Z6NhNLyMKlbtZVp9Zj7cvi38xpc0zZQ3b
 5fF26
X-Gm-Gg: AZuq6aI/FyRlpjotILypj+atBDOFnBt8fr+8OgRgrb1/i+tAS26tA8ki5SyqzlpqP62
 JURN2+w2+z7E7wdMlpv0wqPJ4G36zbXEsLQl9LiEOrdMb1BK5FmWZjuI/pFWRUbZz1IeyO/pQvk
 pxtyTxoDaiW9HsXDaY6RhKGn+sctwkPqfjwAPGL3IaRvAkTNN13pr9+YceCsmyMtR7mnZQwwNwk
 jKfW6ptlg3ZSwtbUfy4bmR45tm+Xsmw09NLWyalwOxY8IyKRmoeh508Qy1UoxK7nen86xSSTFs7
 zw3VTwpKQbLyRWP+QvFU6/+GFTAzq7ET3JUYkTTynVvMjRveF6ju/3myAlcsmGNkqFjL/58jYsd
 D7ruJJWnjdKiYYNAg4BTJ2rk03ViNk31xKOtzyz2XGkvomkEnzJCvjRrsJ/olxQVDYhAiFsyjYn
 Wu0zmeuZXgre0sd4ZhrusxgvMja6BWfhynrT0wLagXJg0v3ibtj02B
X-Received: by 2002:a5d:5d0d:0:b0:435:8fe2:e690 with SMTP id
 ffacd0b85a97d-435b174fd95mr2389950f8f.58.1769130866141; 
 Thu, 22 Jan 2026 17:14:26 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1f7c8efsm3001898f8f.42.2026.01.22.17.14.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 17:14:25 -0800 (PST)
Date: Thu, 22 Jan 2026 17:14:20 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: spinler@cesnet.cz
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 0/8] net/nfb: rework to real multiport
Message-ID: <20260122171420.6479d610@phoenix.local>
In-Reply-To: <20260122072719.505185-1-spinler@cesnet.cz>
References: <20260115151656.393106-1-spinler@cesnet.cz>
 <20260122072719.505185-1-spinler@cesnet.cz>
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

On Thu, 22 Jan 2026 08:27:11 +0100
spinler@cesnet.cz wrote:

> From: Martin Spinler <spinler@cesnet.cz>
> 
> This series implements real multiport for better user experience.
> 
> The existing driver creates one ethdev/port for one PCI device.
> As the CESNET-NDK based cards aren't capable to represent each
> Ethernet port by own PCI device, new driver implementation
> processes real port configuration from firmware/card and switches
> from rte_eth_dev_pci_generic_probe to multiple rte_eth_dev_create calls.
> 
> ---

Wading through all the AI review...

Things you should fix:
- make sure all calls to snprintf() have overflow checks
- clarity about what should be backported (Fixes/stable)
- make sure all calls to rte_malloc et al have checks for NULL

Things you could fix:
- using malloc vs rte_malloc for data structures not shared
  not a big issue; but feel free to change.
- avoiding code duplication
- check prefix of global variables
- mark driver only API's as __rte_internal

Things I can fix when merging:
- am willing to reword commit messages for readability as needed

Things I don't care about:
- release notes only have to be right after series, no need for per-patch
- looks like all new functions are internal only, not sure why review wants tests.
- assume 64 bit port mask is a hardware limit, you won't go over in future.
- driver internal structures do not need doxygen comments
- don't care about any AI warnings like "if you change X in the future it will break"



