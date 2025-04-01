Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C84FC36017
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 20:34:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 85E8C40156;
	Tue,  1 Apr 2025 22:33:59 +0200 (CEST)
Received: from fout-b4-smtp.messagingengine.com
 (fout-b4-smtp.messagingengine.com [202.12.124.147])
 by mails.dpdk.org (Postfix) with ESMTP id 42E6140150
 for <dev@dpdk.org>; Tue,  1 Apr 2025 22:33:58 +0200 (CEST)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal
 [10.202.2.44])
 by mailfout.stl.internal (Postfix) with ESMTP id 61854114014A;
 Tue,  1 Apr 2025 16:33:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
 by phl-compute-04.internal (MEProxy); Tue, 01 Apr 2025 16:33:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1743539637;
 x=1743626037; bh=2d4kgcsbr/HlP3uayQ/IofRF2xv6lAU0j7gv2aq11Z4=; b=
 Fg0nHQ9hQgPet4oZdxMht3jRSBKxKEcj0Nkz/ADYBAiEnxjuK1O6Qg/13aiAJIU4
 TZe206E0nq4cvqVbqe/W2eggpCAMIMPQYn3Avr+L7oEFwg7+LlSaGuJ426x8kSDm
 mGnBFn+G4LNJ0eV9ZQ5yPyDm1tMNfK02mzIcawAkR84ydl+5BNgK9zaxYnZK43TK
 BKp/MrPIiTJDDMVsNd1bXxXg/2bv0lwT9UksY5Z1vWtPJFay8PxHXoYiKS0q1Fmu
 Id3/Keno4rGxqmxPyoqADZlZ9R0HZkMYu0moBzzSQ2e751muUShpQX3E3HzHPhPB
 tWD5W6e5rCfX2sbnHWN76A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1743539637; x=
 1743626037; bh=2d4kgcsbr/HlP3uayQ/IofRF2xv6lAU0j7gv2aq11Z4=; b=N
 Fu8iPCHHJvYdCl3C88KU8Rb0Vm5RaynPasMbvWCWp6WKu1NPh4Jc40d3OtJaxa/k
 z8L5Aa0RCHOCFT2+eX/lLLTLi72Q6oBrC9gX/QenDnOKJqr6JlxdAzeqz14Oemmg
 fOaNHmeu93RbMk1KtZgHuXgJOYyJkA8H/Pu1FJ/h6aGCy7Uz9KnWViQcJvoTofq/
 MrkzBB6p1J0DiqIV20pAlelEqRj45KY7isp0OEm3yea9UUv2Ghu6boOndQYu3WMI
 naixrAY5/9ClpCg2gykUfGiMr3CnVFSMucbiMz/K7KBmXefyLQFIG0GBoqHJd/DF
 vTgCl0l+gBF9bEEKE9uZQ==
X-ME-Sender: <xms:tU3sZ7V1Oxl8FBZLcHnqMeQWpfp2B72dPKX7l_rMjSZEficsbdZ4SQ>
 <xme:tU3sZznY4-qmd8yNAjv5KzjDkMXN4ps_QkF_krHRDdsmzTxyYHJz8lDqPbLNOIPwA
 1A0TTlnpQRdhbjnlA>
X-ME-Received: <xmr:tU3sZ3aeMnHrJ6mL30L2TJSg_2dsuQl_q_JaXedt7vm5ofWtmqQfOmiSvHhkFuzW3_Z-Xo8U7bFQjxy4e3JqMp4GDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddukeefjeehucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
 pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
 gvnhhtshculddquddttddmnecujfgurhephffvvefufffkjghfggfgtgesthfuredttddt
 jeenucfhrhhomhepvfhhohhmrghsucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonh
 hjrghlohhnrdhnvghtqeenucggtffrrghtthgvrhhnpeejudevheeiveduuddtveffgfdt
 geekueevjeffjeegtdeggeekgfdvuefgfeekjeenucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvght
 pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurg
 hvihgurdhmrghrtghhrghnugesrhgvughhrghtrdgtohhmpdhrtghpthhtohepuggvvhes
 ughpughkrdhorhhgpdhrtghpthhtohepsghruhgtvgdrrhhitghhrghrughsohhnsehinh
 htvghlrdgtohhmpdhrtghpthhtoheprghnughrvghmuhgvsehlihhnuhigrdhmihgtrhho
 shhofhhtrdgtohhmpdhrtghpthhtoheprhhorhgvthiilhgrsehlihhnuhigrdhmihgtrh
 hoshhofhhtrdgtohhm
X-ME-Proxy: <xmx:tU3sZ2Xollr0UUTNSfT2A2M-1YGiGYW9m3A21FeDyuYggt5hl7l1tQ>
 <xmx:tU3sZ1l1azaxH012Istx9Jg5jrniaSFWIwWDUaBCCOP1vsddFAXGYw>
 <xmx:tU3sZzeJIZQ4pcX99NGNJTTgSjV2GaSpYcYcSDZlzORdwzRuouWzWw>
 <xmx:tU3sZ_Fn4NaE3W7-aAOHGIenYfW0RCHHGDmcQJZJSYomdOugyUrHDQ>
 <xmx:tU3sZ4v8Y9tDfJoMH-XWuAh8HMAebW0v1iUu6StbjCjjeJfrEfgi5vg3>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Apr 2025 16:33:56 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, bruce.richardson@intel.com, andremue@linux.microsoft.com,
 Tyler Retzlaff <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v6 4/8] build: generate symbol maps
Date: Tue, 01 Apr 2025 22:33:54 +0200
Message-ID: <5363995.88bMQJbFj6@thomas>
In-Reply-To: <20250328105250.3082414-5-david.marchand@redhat.com>
References: <20250305212349.2036410-1-david.marchand@redhat.com>
 <20250328105250.3082414-1-david.marchand@redhat.com>
 <20250328105250.3082414-5-david.marchand@redhat.com>
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

28/03/2025 11:52, David Marchand:
> +scriptname, link_mode, abi_version_file, output, *files = sys.argv

You should add a comment to show the usage of the script.

[...]
> +if link_mode == 'mslinker':
> +    with open(output, "w") as outfile:
> +        print(f"EXPORTS", file=outfile)
> +        for key in (abi, 'EXPERIMENTAL', 'INTERNAL'):
> +            if key not in symbols:
> +                continue
> +            for symbol in sorted(symbols[key].keys()):
> +                print(f"\t{symbol}", file=outfile)
> +            del symbols[key]
> +else:

Maybe add a comment after the else to make explicit it is GNU format.

[...]
> +for file in sys.argv[1:]:

This script requires a comment with the usage as well
to make clear what we expect as arguments.

> +    with open(file, encoding="utf-8") as f:
> +        for ln in f.readlines():
> +            if file_header_regexp.match(ln):
> +                if file_header_regexp.match(ln).group(2) == "lib":
> +                    lib = '/'.join(file_header_regexp.match(ln).group(2, 3))
> +                elif file_header_regexp.match(ln).group(3) == "intel":
> +                    lib = '/'.join(file_header_regexp.match(ln).group(2, 3, 4))
> +                else:
> +                    lib = '/'.join(file_header_regexp.match(ln).group(2, 3))

[...]
> +#define RTE_EXPORT_EXPERIMENTAL_SYMBOL(a, ver)
> +#define RTE_EXPORT_INTERNAL_SYMBOL(a)
> +#define RTE_EXPORT_SYMBOL(a)

I would prefer an explicit variable name instead of "a".


