Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B94C982E6
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 15:54:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30CE242D9D;
	Mon, 21 Sep 2026 17:54:45 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 2E08342D99
 for <dev@dpdk.org>; Mon, 21 Sep 2026 17:54:44 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1cea34f01so2746548a12.1
 for <dev@dpdk.org>; Mon, 21 Sep 2026 08:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790006083;
 x=1790610883; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=K2sViMjbhYVDqt6iiI0/hoXnGvFifwWPrvF7NvI93/g=;
 b=01neIPLAIgXqXL7DxwTUbUeHWU450296pXlDacZ+CtRs1y6NMdVTS1z93thBHN6qvH
 Zh48vx/Dhqxu4mi7tqFJJDSPZ3SDU9SeESWZ47UpR4J0ZLUonJR4ClFsag33+mYYpX7O
 wcVWjcL5b9xph5J4DkI6nnZH9H1pPBq7vO9zWcwwutTNdM0YsLoOfAPDhVAe6qwaRZ4a
 WYPKNcumyOtc2EKwO8FnONsiqBy3i57/YcTL28NnitfZeKuuGe8BXvuxX3qC+EzGBPsQ
 qcngXujb86TAY/sTHbp46PZfhuZ3oE5RaYjx04P7Y2KNdIhXy1ZYbAFFhakhilLCpvMc
 P1sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790006083; x=1790610883;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=K2sViMjbhYVDqt6iiI0/hoXnGvFifwWPrvF7NvI93/g=;
 b=eKFPfBF4LUXpgz7I61XQrreTeGyb+p3EsYmp/d5m5wvhj358UyPn5MO7uQSp7LI3vG
 m2fLENbzWesWvOFXShyIvT9JwIWCEX196KKzpjQiZ3/KZ4wMBfRGSskk0mzbPIXYzRh0
 Qf1MJ+iNtFr00GFMWBOsyWmhuSBlrceMPmhJTA5cinr/niFNveQX9XBts/D7uTf8T/PF
 u1JkRDDZpQEq8ytY4qdyjgHpPjUyEByzEo5kKDkGpHRRiUF7doqJBdvE5ZUklYz2Lb3y
 ecPY8G1a6WoLwvmDN6LnuuSpySFkMJvFkXH8Jo3cSs4tsr1qmtSbFs7VU9XWQhh+frBW
 X5nw==
X-Gm-Message-State: AFuF++n0jkdzW4FKtCG7Lk8iOa9Z4YO+oPHnm8e6H3anheHrU4Vai0qi
 odsR+1CvBNE9FLYrVwD2c/fwxDx0G46sdT9tiLgM7XWZg5TcO6awIsrYpZ+73sfyladcl9QrH6o
 HEMZW
X-Gm-Gg: AYBFou07kdYW3jmFYvcSX9Oj55etwgmOyPrF6y4TgVwl926BbAxrlQ4pn3Ht/528+fB
 tP5E1E0DhBAIVeH+x1+cpFVYw401kFV8nyXRE7GYCzyxGpDXU6SHU82lZ4FDAi2F9SAM8mgy2OC
 OSWvEMAx4j6fzxJu8DFbasYN2d+ipsKWDY7hD1QA0d+MS4IKWoF2QMBbNZ5qmDJeMv6DmQQnsd4
 IOULCe+05ucEFWlH0HfVgX+hWUxGpTPig65igj7aJfYxrGl2CSIqL9VnbhwjVkLA/Iu7+DAfWHn
 9M4RVg7bIxzrklhvyE6wJroGl6XSC9nMTQY7Lk4u6L9iKUKGsPTVsj8uK9xUAOGhJMnwH2eQhiD
 X/Tx2tgS/rMT3tcsp8zc/mLrdiotNPhh+Q0QlDFM1QzLL99gr2khd+deeyRCDBwqA8oKN9Fm8Re
 ij8NCxxiIMtUhz3cR0R87gyfmSAb1vKYFBZIJjM+YNRM2Uh4vGvRbvhcpA8vGoe+SKL5zYmr5cf
 IgYnGux7966IUB6w9aMmgK4+pCJ1EHu+EsIaTyxI/vYCeePDbgB
X-Received: by 2002:a17:90b:37cb:b0:39e:6c69:9b9a with SMTP id
 98e67ed59e1d1-39e6c69b2eamr11627205a91.63.1790006083147; 
 Mon, 21 Sep 2026 08:54:43 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a063c1994esm735465a91.17.2026.09.21.08.54.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 08:54:42 -0700 (PDT)
Date: Mon, 21 Sep 2026 08:48:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, kishore.padmanabha@broadcom.com, stable@dpdk.org
Subject: Re: [PATCH v2 3/5] net/bnxt: fix use-after-free in VNIC filter cleanup
Message-ID: <20260921084844.769fe915@phoenix.local>
In-Reply-To: <20260921022002.1033815-4-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032726.763384-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260921022002.1033815-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260921022002.1033815-4-Mohammad-Shuab.Siddique@broadcom.com>
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

On Sun, 20 Sep 2026 20:20:00 -0600
Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com> wrote:

> From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
> 
> STAILQ_FOREACH()'s own advance step dereferences the current node's
> next field after the loop body runs. The loop body here frees that
> same node (bnxt_free_filter()) before the macro dereferences it on
> the next iteration, so the filter list walk in
> bnxt_clear_hwrm_vnic_filters() reads freed memory to find the
> following entry.
> 
> Walk the list with STAILQ_FIRST()/STAILQ_REMOVE_HEAD() instead,
> removing each filter from the list before freeing it so nothing is
> dereferenced after being freed.
> 
> Fixes: 20ef524432dd ("net/bnxt: set L2 filters")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
> ---

You could also use STAILQ_FOREACH_SAFE() instead.

AI flagged:

[PATCH v2 3/5] net/bnxt: fix use-after-free in VNIC filter cleanup

Warning: the commit message misdescribes the bug. bnxt_free_filter()
frees nothing; filters live in bp->filter_info[]. It memsets the
entry and inserts it on free_filter_list, leaving next == NULL. The
old STAILQ_FOREACH therefore stopped after the first filter. The
remaining filters were never cleared in HW and stayed on
vnic->filter. The code change is correct. Retitle, e.g. "fix VNIC
filter list walk", and describe the leaked filters.
