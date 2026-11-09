Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8123606A325
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 18:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=JatUNeQk
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 746F34028F;
	Mon,  9 Nov 2026 19:01:03 +0100 (CET)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45])
 by mails.dpdk.org (Postfix) with ESMTPS id F1ABB40270
 for <dev@dpdk.org>; Mon,  9 Nov 2026 19:01:01 +0100 (CET)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-3ad787e0593so644566a91.3
 for <dev@dpdk.org>; Mon, 09 Nov 2026 10:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1794247260;
 x=1794852060; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HNYDnhkXLSom+3qS4AOiUu/WcvjWo4PrFUcB+fUE1gs=;
 b=JatUNeQk0KEqaEnIf76FpPp7Lj5gJfBBus8X/WMa7G1plJVwJwJ1NPMv8koN9uLZ8h
 ar+f760tZVkoXY5K6tezTns/exbcgKX2KnkC3FDBiyUeBQh0tIcnXHw6Cb3DX4wY5JT9
 ICWuSn7YkXO2NxFmYfFDq1RbeLCXOv7YubnvBOnjx9rt+K4H6x0obhO7hDHhi8SiOPeo
 DiYp7xwZ2/9KQHI0t0ozWw5B8LEpRHWts6gGWUnFouIcwXDc9PHwJE9K+wu06dhlFgi+
 LuZpOSPXn2z40806pgPEWsi4uymf2qQc3qVdJVDGp4tjnWQlwBHl3SLPm6SAQOXrZGs8
 k0Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794247260; x=1794852060;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HNYDnhkXLSom+3qS4AOiUu/WcvjWo4PrFUcB+fUE1gs=;
 b=iCnm81hthRdNbJbCNKIYO9C7X4lUHb08lWBK/hpur7GoxKhWvntMUcFO+6eUhTBnZj
 eCUrtRvldGytmHN4dxgUAc8NypVYNsCMb1dWq8DSpu0DbiZzT/nvBArbOA01lGl2TNtp
 0LS1v6qFMA1+4N9xkEQ3kdzdVwASVfp2XfJeGm0yglKQXwLUv2hgwz+hbvbo0/E9zwnt
 BfG7DoZmtk43S336ZhnWCujCkGEkj38skJP/wdke4XJ/pePSsY92zPRjmVI4Lu+2BKir
 s8xYNiugn+jlRXQpEq1IJVPnyPcOf2fnugHv/pZyyFjTBjFmlSd2rWAotkb+Sb7eNrA0
 JNPw==
X-Gm-Message-State: APuU4Z/BIz2VCR6ihKsnHkCbhmQGpoKJQUXyoOJbQxKr4pVd5NEUV5p6
 xFSAk+RS+X2Tj2yWxaydmLbEG3AkDhxkNaRYJRxtCjzbyV7mxJ+1bEuG/4g5DdM7Orc=
X-Gm-Gg: AYBFou028KBLxGJYL2bzGfbXZrNi9N/5gPP0dL87LggPg5wYSma4U8QeT2kPIWHNFJ2
 UjzYSqtdjp6Orumfcomh13uX/FK9VZFO51CCrVrrdTUgY372AcH0ndHZ34+mQHp9Dd9Ty/2t/IR
 oVwLvYzzamcuYnyqaPABPeDKSUr88Qbiekg6AwdvMJWFm6O/z06ajH8ZWkbr02vgtT6r2fiU+8v
 oHqfPeMoitAsOMVVWcPa+2PkVqxHl2VgHoa+qdZfC7RsOFIRx+/kcIP1wU+25IB7cn1oY+1EV6u
 rUhI8JRnnYj/NZorECWDRqbeMno7L2u1JK753i/aw2nmLPihyKJVc2dQXUd3Ex0Ly8PeKPaohaE
 nwAzz72KbA4WrOyY4t/0isgPkyKvAqKlw/1eQ+keB6VwtBhvBkGOaUqU5HMlgsNkPpsvqtAUeWw
 dSB2KHnft+ITj4MMUXrkAqh6rSOV4ryjPpdxRWkqSJMl7jK+9ETgbKtZ8UMmxysUfysUSEJJNfM
 xg45cZGEl3OJiZqPE2z73B6Hph0q4GEpYVlrKByjO37kbFRbkzLAftg6qNLvdWkEYnzcUcKg5KN
 rCp/d8dzQeFKKdSEVPiIiQs3ffqM0+Mbaqs23xGJUcZzPZOind5N7XXr8SXjxyq6sws9v/3MkBb
 4lmHmHDqAIfX0JC/3cQ==
X-Received: by 2002:a17:90b:2e42:b0:3b0:db88:4894 with SMTP id
 98e67ed59e1d1-3b166d02c5emr361106a91.35.1794247259951; 
 Mon, 09 Nov 2026 10:00:59 -0800 (PST)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b168ad3131sm24845a91.0.2026.11.09.10.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2026 10:00:59 -0800 (PST)
Date: Mon, 9 Nov 2026 10:00:57 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Zhang Tengfei <zhtfdev@gmail.com>
Cc: dev@dpdk.org, jiawenwu@trustnetic.com, zaiyuwang@trustnetic.com,
 stable@dpdk.org
Subject: Re: [PATCH v2] net/txgbe: keep flow rules per port
Message-ID: <20261109100057.6c1a25c4@phoenix.local>
In-Reply-To: <20261109125149.16218-1-zhtfdev@gmail.com>
References: <20261108160021.31789-1-zhtfdev@gmail.com>
 <20261109125149.16218-1-zhtfdev@gmail.com>
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

On Mon,  9 Nov 2026 20:51:49 +0800
Zhang Tengfei <zhtfdev@gmail.com> wrote:

> rte_flow rules for every txgbe port were stored in file-scope lists.
> Flushing or closing one port freed the rte_flow handles of the others
> while their hardware rules stayed programmed, and probing another port
> reinitialized the lists. The same lists are used by the PF and VF flow
> operations.
> 
> Keep one flow list in struct txgbe_adapter. A port disables flow
> director only when its own FDIR filter list is empty.
> 
> Fixes: 5c2352b9ece6 ("net/txgbe: support creating consistent filter")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Zhang Tengfei <zhtfdev@gmail.com>
> ---

Looks good, applied to next-net
