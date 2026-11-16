Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FC7606A32C
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Nov 2026 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=WWfjAcfS
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EEB934026F;
	Mon, 16 Nov 2026 19:45:01 +0100 (CET)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTPS id 8F4A240150
 for <dev@dpdk.org>; Mon, 16 Nov 2026 19:45:00 +0100 (CET)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-2efc5a60bd6so4585715ad.3
 for <dev@dpdk.org>; Mon, 16 Nov 2026 10:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794854699;
 x=1795459499; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=fFsaFEW8tdX6OKTDrW3B2Sx0TVzd9sOwa6HgXxuZ4Pg=;
 b=WWfjAcfSQ4EdHgYHLXkg6wsC7/sKrRCceMx4aDr2pUnWdqAdKkZjyCtCZ+U9duE4Tt
 1ngKMuWZeTqT4PpyA9zfTdg17MAn2F2UjxJgRWqa5Z+ugqlnmO4nuy1i19f5SnKL0FLh
 Vz747gSfDyPGZ8dvEkw+LzLRdLbEa55nDvlL8k0jRzhtbenQdLdeIkmLw3DxsmWJLfH9
 nvT3Y/lMvESHEE8NptwdeODseYFki9/jiapjP0bMCClN4fJMezMNMBv9lnBkl1EQx+nh
 Y5hCR7u4iDW5qJ60SvQf3pJNAqa5N6NxSRpcjmPaRyL7aUPukq3thZl6L3HJinSDnqHN
 71gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794854699; x=1795459499;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fFsaFEW8tdX6OKTDrW3B2Sx0TVzd9sOwa6HgXxuZ4Pg=;
 b=VQCPkUOhSXHubXY/Y+euF0n8pzA6A+/+c8XkhcjcLEnvNu2CLIrsmojFia3YphSEez
 1H97k9BhV5+Il3A/pBqggwB64JYUwqPI+BfBQoBILUCi8NIlagSDhOAtkX4BdOPTy3bt
 07jbp7ygFy5r5syfyOfM7WKOZhUZ2aDAmOzNgUUi278D0V5DgDFrFhuVdU7ha2PUzn3v
 zEAllWFEG6Jz1/IKfd+JrrYUFH5ZMwYqIHO7U03QmEE1iixECgwm0DSZTk9vNaMBazck
 v3siVoS+Hp5R1mf8ggFvdjUu1uwrzgoLjVFAaIhluC7HLWeT7HuiR/BXP2gdxmBaVzxl
 VXsw==
X-Gm-Message-State: APuU4Z9L5Qg0ALJQgqPuwhcKlRzgtio04t13Tb4R9lZf2AhjzszVcQWD
 5/aKEbe6sdztKARAvpELCZ5gT27vQw8Z8ZhS205tQChOyxWN3BQPOR3mOXu3lxcGA6o=
X-Gm-Gg: AZFdTZc291U4VLhsmioHac7UtGXvEhxatFyxX2NQQMEK1MS0vu3pL+rCf2mnmfpErnb
 O/4W7zLWIFbOiFkPOfwfgGyUDE6FC2tbqiMbjBze4zB7Mk3ut+dAjOSdXjemkww0xwR5qxKwLc2
 weXzGt1Vpv5WQewz1VgA4sHRBB6n+nL4JFkbGUaEbQ/tQs3Baph14XYs5MLYpCVE4+pywsVbN4o
 3599FWQ779SorU064gKjc1lLqWlVGx2G1hcSGsrzt5tQklhAmmnwTbDkwyxxaE4d0xK4TpKU2zf
 ruAmfWqHzy/XrUUaNKS7d6RW20045fIEk5yidt1sH+AYn9V7BOOUvS7KvDUTzY3nAjt1e2jV6ow
 6wbWfX6xQXktIMsrr4BsR9xlLQEqGZnkUFLGACE/DNozSwEjbQngdvZvX57N7A1YrEstdpDP0Tb
 Q7nsOyd+2gTQJrln2QWIV8c9kZ/yLO6q44FWH3WZrWbzBlHair4dcvxhfPLykX8uzEFErPw1yPh
 FAY4ilbGrkLhk8TE6TZau2BX+e42Po4rgx/Gxag/2W/KB71twk7WYZ1ug7cGsH1fj2fhiOvLyQ7
 ZzI7LQVb/j+hXnWQvFOuTadochYHuZye+Ny0u6TEQkG+BinCUxljix+6kp1oH4+rXwxh7lBMYA=
 =
X-Received: by 2002:a17:902:f78b:b0:2e6:943:39df with SMTP id
 d9443c01a7336-2ee0dad0665mr111258975ad.25.1794854698779; 
 Mon, 16 Nov 2026 10:44:58 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2efd7a3c821sm3190515ad.37.2026.11.16.10.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 10:44:58 -0800 (PST)
Date: Mon, 16 Nov 2026 10:44:56 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mujahed Mohammed <mballas@nvidia.com>
Cc: <dev@dpdk.org>, <stable@dpdk.org>, Thomas Monjalon
 <thomas@monjalon.net>, Aman Singh <aman.deep.singh@intel.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>
Subject: Re: [PATCH v2] app/testpmd: avoid mbuf pool memzone name collision
Message-ID: <20261116104456.1092a4c7@phoenix.local>
In-Reply-To: <20261116112556.535445-1-mballas@nvidia.com>
References: <LV3PR12MB914444BAE4DA3B85B4179A4AD47D2@LV3PR12MB9144.namprd12.prod.outlook.com>
 <20261116112556.535445-1-mballas@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 16 Nov 2026 13:25:53 +0200
Mujahed Mohammed <mballas@nvidia.com> wrote:

> Additional mbuf pools append a numeric size index to the base pool
> name. Mempool backing chunks also append a numeric chunk index. If
> the base pool needs multiple chunks, its chunk name can therefore
> match the metadata memzone name of an additional pool.
> 
> Add an s marker before additional pool size indexes to keep the two
> namespaces distinct while retaining the original index-zero pool
> name.
> 
> Fixes: 26cbb4191e91 ("app/testpmd: add multiple pools per core creation")
> 
> Cc: stable@dpdk.org
> 
> Signed-off-by: Mujahed Mohammed <mballas@nvidia.com>
> ---

Looks ok, but I like the AI suggestion to fix it in mempoll code
not just in testpmd.

---

The collision is not testpmd specific. rte_mempool_populate_default()
names chunks MP_<name>_<id>, which shares a namespace with the pool
metadata memzone MP_<name>. Any application with pools "foo" and
"foo_1" can hit this once "foo" spans more than one chunk.

Please fix it in lib/mempool instead, e.g. use a distinct prefix of
the same length for chunk memzones ("MC_%s_%u"). Nothing looks up
chunk memzones by name, and the name length budget is unchanged.

Also please add the reproduction (command line and memory setup that
forces multiple chunks) to the commit message.

Minor: braces around the else body if a comment is added there, and
no blank line between Fixes: and Cc: stable.
