Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5C9C43327
	for <dpdk-dev@archiver.kernel.org>; Fri, 26 Jun 2026 15:08:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 407DE4026D;
	Fri, 26 Jun 2026 17:08:19 +0200 (CEST)
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
 by mails.dpdk.org (Postfix) with ESMTP id 5F8C140264
 for <dev@dpdk.org>; Fri, 26 Jun 2026 17:08:17 +0200 (CEST)
Received: by mail-dl1-f46.google.com with SMTP id
 a92af1059eb24-137eb0d76beso1272278c88.0
 for <dev@dpdk.org>; Fri, 26 Jun 2026 08:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782486496;
 x=1783091296; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=E0OwljUTTvwsxFNpc8GgQFX9JBFTHKQeftHQ1C2CgIQ=;
 b=kB+JhI5KkU1Dn2x+HDnVQVfEOA0cS+OsTeoaMUyycCzcplcvLjkQNDZSNnqWev2741
 8TJrhc65eVTxpdv0AlN29edX1/VcccN+0WpCOk39gfFhNAh3eYz7wxoPHWr5pseDG6ja
 CJ9RkV1P2tEEPLevLDj/+5EFsGIMPlRGhj9HLgYSdSkIs4i5I3z4OcbQ/ESXpjYCgsDN
 W8W4zOqi/t+5Xskxzkh0BM+oBctsxCQql+tDw/Ozw0lIQlp+96drjnbhbaxVWphtBqWE
 H+If1qh0LmsQMqDLwqCSdcUlKZRVGK2yCBENd1WOpsNmKfCF3KIbokRvwyTMis3hdp4l
 vsxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782486496; x=1783091296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=E0OwljUTTvwsxFNpc8GgQFX9JBFTHKQeftHQ1C2CgIQ=;
 b=RelcKKlwg3rqmjat71yhO4dTSO8wV1CWHe/ieL/nrR0THXl1og5mT2KQ6DhfeZwEom
 XA4/KARwh+TimzC4XNEt/tojKO8pRGcOWi+de9rPIpymHnuoroV62ukF3N5cYgfpyNbB
 3j/e7naqjpBrZ5tam02RmQzC59ysYyGUJ/RhhRPPNftc3UgdaqcvMkaLYRjvYcY68uDq
 L5avpojooRP0nBEgqACS9PqgyVwq3de2NUo5dmOJgl7M/x1Q4ow+L9ocv2yIVXzEdAgz
 6+OW9q0rfAD/djUmEXqsQEm1KXpKUURoQOVR0kjX1IP2tyg8PffT2mILrR87qQw2TE6r
 OLog==
X-Gm-Message-State: AOJu0YwSA/W+3pm4uq3XVGqlhXoZs9vGCgMevQqyR3kYqfcD0UpidgVz
 eoKVTKlc45hTc1WeXKIZ+ab5V9qk8ZUhMwTYEqC+TXwg1wZf6+NqYlXZxoVIMhn/Erk=
X-Gm-Gg: AfdE7ckW3ptQ4P/N5szd/uePCPjoUU5g3K43yVwD3gbj3tiuChMxs8WkCCNuWKnz/A2
 pkauYxuRklpqUniNJvzpYerv50MvHDJxmRcxCtIZPdIgHnhhcOgAYO8sbn82+y97bfjuB9ifCut
 d3kDUEZj+IsvLOfTLRd+DMGGPU/RgFqgX7UDukEEEN2PHittzmbr3nghD/ddE/H3C792fEegEJ5
 89athD05ES6AzBeULSLxu1rN3YTBZ/X92JzB9Z/XHessnmmq22SBf7ZPSgi6PE3mdP4ao4FXjmL
 LJHHqqeI+YTnVzPLyPw/FcOur7ik70nAG2YOwxnXz1kPIQFLvu+39loDxWE+ql1JbQmWX6AMzGr
 UZJILuf4YwOvFydSFppA8gp9Re1gSmVjLjGJPwc8IbkQ6TiUgOlwuC9ABtkTKIGyiJR3yNvBRuf
 MOb+EW+mxQjKUFy7zb3mBoEZfjo2M5gOH6UVM8Z3/3tglhdq4vFI9hfZQZKwYzVqNS
X-Received: by 2002:a05:7022:ff4b:b0:139:b0a7:9e0c with SMTP id
 a92af1059eb24-139c3cbcb12mr11849668c88.14.1782486496189; 
 Fri, 26 Jun 2026 08:08:16 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139e4c33af7sm6122643c88.5.2026.06.26.08.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Jun 2026 08:08:15 -0700 (PDT)
Date: Fri, 26 Jun 2026 08:08:12 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Jianfeng Tan <jianfeng.tan@intel.com>
Subject: Re: [PATCH v7 2/6] eal: use request ID instead of pointers
Message-ID: <20260626080812.2a2bc53a@phoenix.local>
In-Reply-To: <4f373899b3b4dc3e529e31f5238594b4857b41c3.1782469943.git.anatoly.burakov@intel.com>
References: <cover.1782469943.git.anatoly.burakov@intel.com>
 <4f373899b3b4dc3e529e31f5238594b4857b41c3.1782469943.git.anatoly.burakov@intel.com>
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

On Fri, 26 Jun 2026 11:33:57 +0100
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> @@ -1178,6 +1203,7 @@ rte_mp_request_async(struct rte_mp_msg *req, const struct timespec *ts,
>  	 * it, and put it on the queue if we don't send any requests.
>  	 */
>  	dummy->type = REQUEST_TYPE_ASYNC;
> +	dummy->id = ++next_request_id;
>  	dummy->request = copy;
>  	dummy->reply = NULL;
>  	dummy->async.param = param;
> -- 

Is there any chance of two async requests being generated on different threads.
Would be safer to use an atomic for this?
