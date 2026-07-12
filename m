Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B429CC43458
	for <dpdk-dev@archiver.kernel.org>; Sun, 12 Jul 2026 10:12:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 776D040276;
	Sun, 12 Jul 2026 12:12:18 +0200 (CEST)
Received: from fout-a5-smtp.messagingengine.com
 (fout-a5-smtp.messagingengine.com [103.168.172.148])
 by mails.dpdk.org (Postfix) with ESMTP id C7D284026F
 for <dev@dpdk.org>; Sun, 12 Jul 2026 12:12:16 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
 by mailfout.phl.internal (Postfix) with ESMTP id 38CEDEC00DA;
 Sun, 12 Jul 2026 06:12:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-04.internal (MEProxy); Sun, 12 Jul 2026 06:12:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1783851136;
 x=1783937536; bh=YJrgt6bNsfSi+JjZ/v8MGhNkQ8Ie7Z0i5x5iOaOEFAE=; b=
 aSQ2ti+/CtHeIWQcuC5RYIcvMmkBtocsH19tWEarNAynKtHUHb4A3rZ6dumcJJqK
 fyoxdWn3xIzpVwUv37Lvwqj8CUjaYRdSQmdR3o2Uh2ntCk+4smX94YYqaoibmI3O
 kXDk3weM4ElZDbLh3I1pXvLUi637o5NcvGtzktwsCLJpJ7Dg6TkzfTVbulSpkrvd
 0QYJq6e8NaOEuESNYdyLYDYI38nkVSXAsZzcVaSuzLmNrnUTPO4+x/mXBuwXl765
 8RsdMtiVn4rFFko0K2oM/nIFlKMbQHBd0Z9Vp+fX9kTQl6F9bNL8gb/2agaE22Br
 F5WGndGxIpDSXmeduca/tQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783851136; x=
 1783937536; bh=YJrgt6bNsfSi+JjZ/v8MGhNkQ8Ie7Z0i5x5iOaOEFAE=; b=Z
 3Qp3pfpFA1/cL2mQCfZjjg0os52nJR6qVPRlsKGXTSkb356lqZH/iGuVjCirDuoI
 CCrfhl8rhValI2CjAHDiZYJlwfUXas7AT2zKuspScYxPhdByZCasKobXQbcS+7/h
 WcNvK0CO6hj/cjUfqwaBu0/9icptL340zZRmYmWRzJ3f+qAllxA0haAKa0RoptG4
 M7HhVNeosZrHQikDIu6d+/WB+rmCa8rXmbAJn8sTTboiIT9FLA7t/56IgTtPUrKO
 j4BoPFepvux6V6GJpyLZ5dlO8LNpzkohfGmBMPpQx+Hfv74ylqT8nloPFWn3EcVy
 nExPaMW/GHlN/+5RrGbXQ==
X-ME-Sender: <xms:f2hTahw4AR8dki5nTJEXKqkeZmKa5U6MCKtM7kuUiA-OOVOSRYfJ8A>
 <xme:f2hTaln3VetB_2Nuis6p4zw5-_Xb2TqbqwXAGKX8UJo6xXEtSz8SoQdVRdwfUcpcI
 _KbP7qwdd5PfRSXHIKfNMpjBLFk8WhxB8HSIN47SgT04i7seDFY0A>
X-ME-Received: <xmr:f2hTaqf5dH9SyGp2SA7DhLyaYh2ieJRkRnTWl3BDNQpQIg7tML-lnmYymrXc0eiNq0Hsn0oBJdnOYqkGhuDkNeY>
X-ME-Proxy-Cause: dmFkZTG0UxkprGbhdQssHYdF3QbZ4c/5ttT9W+O57GxxBgNos7QT8O25PaQ0XhUbl+3CZ+
 vJ9/JbBZIZgAAAdrTXOgo0RBTt3JKXttg2At0mRSFRfaMnz6c3VVvecygL7X5mhb06U4r2
 P2WjV5BJIGpSLeq972tYAUzMIklsoSkQjGthy13jrJdzJ1LA9lCDdqvx7aCzYHvP6LSohi
 7jcPVWAR37w2cjwHZV2xgFRnxgsrLGLumEOEibw1jTh0hJWAI2rcME2Q2AQwP6kbBX7/o6
 tZF6Ka9WqFUfN+tCR2IyFsPOCiLkG14ofsfnSBmxv5IpZhCipq/gOlq7Q3sstErBF5G2Ag
 JR7BwwKylYSx4ESMecVWa1HDEjR7TGU5SrrJP78t+5p9ZA5l8b5Clt8qp2EQ9WWNwEHi5G
 SwmWB3XKRv4MmsD60U4CserYGwb3TqPM9d84ba1/Mvuo32Z3mfT4LW85bG74odIyyIhkXw
 VyVf2urt0iehmRijYCqSu96FCENQfYSTxAbC6/2x2ccaWWgOMQ5bq8ul4HVn5oiTquhD8U
 UujidY5nMhRtat/HkH0Uew0b/nIRlpFusr88HIgtKqInra0BsbeQ7+CzDNkBJdXCZXB93w
 my1V8HqDDm4aauOb6L5DFnzmu+tRvRxTPJ8fVghpy4+buYG9cssqPaiEkExw
X-ME-Proxy: <xmx:f2hTarpN4AaK2b3M8sJIIsO2AIaWPHxNuhPSEzydPe7b60NJQbaNjA>
 <xmx:f2hTao48TJt8bkGSpxro1hUFEmPaIeLmILg3XhkcTF_EcrcBhSLPPQ>
 <xmx:f2hTahrgj32dAbCbh8maPWLXpSoTprXbVe_40gAFdM0smQMNztW3cA>
 <xmx:f2hTaqhC80c-Sk2XLV5SlR32ymo2aqc8-g5L6iA6Pm6HArqe9gjsVA>
 <xmx:gGhTam4boCIhI7gd0d9bSP1AzbLNyKOTISZw8IrFaFVxWQvv-z0vWxQH>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 12 Jul 2026 06:12:14 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, fengchengwen@huawei.com
Subject: Re: [PATCH v3 2/3] usertools/telemetry: support using aliases for long
 commands
Date: Sun, 12 Jul 2026 12:12:10 +0200
Message-ID: <-uRlrpUoQH-bGvgVZvba_Q@monjalon.net>
In-Reply-To: <20260609161400.3661268-3-bruce.richardson@intel.com>
References: <20260521153913.82634-1-bruce.richardson@intel.com>
 <20260609161400.3661268-1-bruce.richardson@intel.com>
 <20260609161400.3661268-3-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
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

09/06/2026 18:13, Bruce Richardson:
> Similarly to how shell aliases work, allow specifying of short alias
> commands for dpdk-telemetry.py script. The aliases are read from
> "$HOME/.dpdk_telemetry_aliases" at startup.

I don't like polluting the home directory of the user.
We already have these files and directories:
   ~/.config/dpdk/devel.config
   ~/.dpdk_telemetry_aliases
   ~/dpdk-traces/
   ~/dpdk_graph_pcap_capture_XXXXXX.pcapng
   /usr/share/dpdk/telemetry-endpoints

I think ~/.config/dpdk/ is the best place for our config files.

It is not blocking the series but we should work on unifying these files.


