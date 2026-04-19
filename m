Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52A71EA71A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Apr 2026 15:41:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 664EE402D9;
	Sun, 19 Apr 2026 17:41:51 +0200 (CEST)
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
 by mails.dpdk.org (Postfix) with ESMTP id 154D4402B5
 for <dev@dpdk.org>; Sun, 19 Apr 2026 17:41:49 +0200 (CEST)
Received: by mail-dl1-f43.google.com with SMTP id
 a92af1059eb24-12c637089ccso5497214c88.1
 for <dev@dpdk.org>; Sun, 19 Apr 2026 08:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776613308;
 x=1777218108; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XOCBRg1CEXtmyNIfJ9GSobQVLn/M1Jvd/I8ZCbLNlD0=;
 b=YXarDULWeeFSJvmV7ZJempBCJkCY+vuZsyxKxa9gu+XBQyV6GwqoM9HsNkKDrSRd4m
 681Tpoc4jq/NijYLSdXCMuxfY7STC0OfEiBOuJN8rPxqB67PpiObPMvgu0Hak8GqfPs1
 yMevLHtCa1o05tnPbjH+dkBo1eBIRCH3lv4FNf5isQfTsUxXOxb5mmHMphzFULqFH4sp
 pkQcql2pSXaSxzHblP7iD/afIG+M8La8bN6NOPLd6Mfuz0uPGXw6uYTexc0q3XEwgz7+
 RExmKCk2bY2hQ8Mtic6Upoq8SRWBWOGHNIoq0BiuXAd9UIlwvJkP74irhDktMJn/xY5z
 JA5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776613308; x=1777218108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XOCBRg1CEXtmyNIfJ9GSobQVLn/M1Jvd/I8ZCbLNlD0=;
 b=kVWNjJ83YbexCWxW1dPBBt6e0cwP+b2Ju7dlbn5klyds0tFqFCtAoVR0RLFEI/EC7y
 OGxqJvScofb906sDDdsxDkNKNxLBeu3g8NjGxqEs2K5VUXUt2S2FGUxd07aFbbxppf7n
 UsnN+wkxxYxQ1zpQK7ZpsdNxWfNzL+IAjEsZskgYNWmxiZJgMUArOZtNp9z65KBOGqBM
 cIpI96c3YXyiM6Zi8RgjuCmNs9ThjuZOSiR6dGQ1koc+7wQUhnU4T0HoW72wae1qHE6r
 YgNlFXi7PZRH8lcRWm+y8JwxMu0ysebPWD/132dOa3IHh+Pdc/QAJRxaI2Q/V9/CyDvD
 14Bg==
X-Gm-Message-State: AOJu0YwXqYuwHnXIeJp6jUhvkbjyNZ0dzA/lUKXbGa+Ksn94+TTh47u+
 dT8rQnc1HbEOOdgS6kHjcUozHhSZEQx6j9/rZHySNI0du1oSbZ5ZQRSUJ1e63y+IC+Y=
X-Gm-Gg: AeBDietUkwt+2q5drAmgzd7uMf5MBryZjEYRACZ2MbH42QyAQNte2+zzfQv/HH3So2n
 6ovrlr/BGOgEppRZ+cE+lxJsK9OUo6GNiIXBXDISg0mq2eyGDJ5FYsKQtt9Ni2t5ACtq7Dce2UM
 KBX2x3tnnZYEf3BytbL2nQtJM0IuYt+ewOn+A005q+3WLCCNrjh49VrFdWKwkE0yt89tPJTwgXn
 Z5pYhpFHLsoCn1w3iGH9QNdAwnpxIpaoL4jhYYYH051X6MgJyGZs6k6TWVt7fVrrm17MBiiI7gg
 6UBlgXiwIfB9d927V50+yvl9nzaSnPyKkTycGZk5xzswgboXWxXglUBL5050TxHZaU3ecLRWU/F
 GQnoNDPFG/rCnqlRU5ebZMTa9U+de1oP6WKh0rv+iiWla53EDSMGClE0ku/NzpqCfyBYIFE4qGU
 edHKc9u2g44wDb+t48OuSdnEqI1TfTwJy8y4mk0ZCJggXsRw==
X-Received: by 2002:a05:7301:4593:b0:2da:10f0:a8de with SMTP id
 5a478bee46e88-2e464db026fmr5128715eec.8.1776613308030; 
 Sun, 19 Apr 2026 08:41:48 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53d2cfd3esm10132258eec.21.2026.04.19.08.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 08:41:47 -0700 (PDT)
Date: Sun, 19 Apr 2026 08:41:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Bruce Richardson <bruce.richardson@intel.com>
Subject: Re: [PATCH v3 05/29] net/intel/common: add common flow action parsing
Message-ID: <20260419084145.53cb5215@phoenix.local>
In-Reply-To: <f9fb4aed4467f90a541c7f36af23817be12e8c9c.1775826526.git.anatoly.burakov@intel.com>
References: <cover.1775826526.git.anatoly.burakov@intel.com>
 <f9fb4aed4467f90a541c7f36af23817be12e8c9c.1775826526.git.anatoly.burakov@intel.com>
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

On Fri, 10 Apr 2026 14:12:59 +0100
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> Currently, each driver has their own code for action parsing, which results
> in a lot of duplication and subtle mismatches in behavior between drivers.
> 
> Add common infrastructure, based on the following assumptions:
> 
> - All drivers support at most 4 actions at once, but usually less
> - Not every action is supported by all drivers
> - We can check a few common things to filter out obviously wrong actions
> - Driver performs semantic checks on all valid actions
> 
> So, the intention is to reject everything we can reasonably reject at the
> outset without knowing anything about the drivers, parametrize what is
> trivial to parametrize, and leave the rest for the driver to implement.
> 
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
> ---
----------------------------------------------------------------------
Patch 5/29: net/intel/common: add common flow action parsing
----------------------------------------------------------------------

Error: In __flow_action_check_rss(), the queue/queue_num consistency
check has inverted logic:

  if ((q_num == 0) == (rss->queue == NULL)) {
      return rte_flow_error_set(error, ...);
  }

This errors when q_num and queue are both absent or both present (the
valid cases), and accepts when they are mismatched (the invalid cases).
When q_num > 0 and queue == NULL passes this check, the subsequent
contiguity loop dereferences rss->queue, which is a NULL pointer
dereference.

The key_len/key check immediately below correctly uses != for the same
pattern. Fix:

  if ((q_num == 0) != (rss->queue == NULL)) {

Warning: ci_flow_check_actions() returns -EINVAL at the end when
parsed_actions->count is zero (all VOID actions), but does not call
rte_flow_error_set(). Every other error path in that function sets
the flow error. Callers may report a confusing empty error to the
application.
