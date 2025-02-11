Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713E6C0219B
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 22:10:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D07EC40E0C;
	Tue, 11 Feb 2025 23:10:52 +0100 (CET)
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com
 [209.85.214.173])
 by mails.dpdk.org (Postfix) with ESMTP id 8B3FD4027C
 for <dev@dpdk.org>; Tue, 11 Feb 2025 23:10:51 +0100 (CET)
Received: by mail-pl1-f173.google.com with SMTP id
 d9443c01a7336-21f74c4e586so67465075ad.0
 for <dev@dpdk.org>; Tue, 11 Feb 2025 14:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739311851;
 x=1739916651; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0j2H4jltKmWHJVghoWNjGZsrWwSL6S+OP6saV3GoSaw=;
 b=KEpwTq6nCA9pwNeA1Pfu7p5xGcuhXMA3ga5/GETzqnmyxXKyWM6YM9siIXMjlE5UUh
 QsGNmTD+t/cyvBFBeFYUbB8DdegyWQAHNWhxn2KoL9jU3Tl69NyYPzCJuMnmdr3T3LrH
 faLSShyt83W/D5a5wX5/3wAqgpZchW2l32qu2+w2dXgOZfcaxJYwjeoUUex3VdtD1s9k
 umSbKeRDfTEVy8bVoxkv5EzybKFVlGspn1jf2zsDkRc/Pn5zs+LxDYb3pwyJ5L8MYGga
 AoXqbeY3VYPiJjTLJGXxaySd2kJhJMRxlP4yAItyHhsgafcYy+c1ryYY7l85O6PUv6AP
 NBAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739311851; x=1739916651;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0j2H4jltKmWHJVghoWNjGZsrWwSL6S+OP6saV3GoSaw=;
 b=lrurpPGyk/fnRt24Pe+Sr1txRyANZgwe4mW8zj1KYIhaIINFYZyOPwrkmfurmuXe5Z
 RQLxRrjJ2DM+Iq1capKeMhvARndKgEFqWXhR4mjqVtTnT7xz07NulZuNQqUKo8pdy40B
 QcfMgc/lVXOluI1vbwBbUBSHZDlljHK2ojeyou0kV7Aj5pqj2w660GyqzPcbIa85G6zD
 cC7cWHPBJxhugdx5xjVRdUrLXOYr6KuGA8icgM76Rcg84qaBnGf1xWbri88P6SCc5PRG
 Jcva21LcmZ3uhyyQ6vke6FtXzfJmus9x2RQ6tSeN82r4AczAl/Iz3AjeJKYkUH7t6yOP
 /7bg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXP/gq3Z6ZZ0HXNVgzkUsGDRuGNeUK6+qAmCHldKSA84QRZsegxxg7mqI/bdWj1akAMcT0=@dpdk.org
X-Gm-Message-State: AOJu0YzbBJgVllWCFdCHd1r9cFpewFwnxb6v4TagOX5oU9KJaK/EMQ6O
 88c5ZpoiWFC4EaY/ZkfLmRic5CqLRZujSiw5QdlEW+UQvuP8TZh3N7RlOvYB456iLlljSOKubn1
 5
X-Gm-Gg: ASbGncvJNMkJ7I6AjDBRxXcKxlf55oG/TT4aG5KW0UZsYAIIBWnq6byeYGxKnEg6VcB
 GoeCRpAAW8VJsO1Djk1p3r9ZqbUvINwsqcOg9ph8mQnOwFfXv0OYQSW1Igd02H0NbxS/rdZRRy2
 foQpDiQy/PzlNWIQqguaPf98irNmiYGLiqWP9mQqJzO6YXZ4S1dYppp6+rmQE67c2xVmVuDf5K+
 5O0lA15g1+264P6sRkeD2vO3Jadl1S0L5kEsbG9PQeQsHJBFCUnAInsVUaiYkhwEavot6VLMVZI
 xl4axwuxR3NmydC2AQnkQb1AZA5xxcIsPwjgr3bZ7BKnWGkLHtwJw3Hxm4QqwyBWOJa3
X-Google-Smtp-Source: AGHT+IH2dPNN4X3gbCtdBBmT8x7gaEFSbF02oY1EBqP8+ewlLSC8PrEo4W5pquurT6/ebxcysI0SlQ==
X-Received: by 2002:a17:902:d50a:b0:216:60a3:b3fd with SMTP id
 d9443c01a7336-220bdedcc51mr6814325ad.3.1739311850753; 
 Tue, 11 Feb 2025 14:10:50 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21f368797c8sm100336245ad.159.2025.02.11.14.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 14:10:50 -0800 (PST)
Date: Tue, 11 Feb 2025 14:10:48 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Andre Muezerie <andremue@linux.microsoft.com>
Cc: Aman Singh <aman.deep.singh@intel.com>, dev@dpdk.org
Subject: Re: [PATCH 03/10] test-pmd: fix printf format string mismatch
Message-ID: <20250211141048.5b73d49e@hermes.local>
In-Reply-To: <1739311325-14425-4-git-send-email-andremue@linux.microsoft.com>
References: <1739311325-14425-1-git-send-email-andremue@linux.microsoft.com>
 <1739311325-14425-4-git-send-email-andremue@linux.microsoft.com>
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

On Tue, 11 Feb 2025 14:01:59 -0800
Andre Muezerie <andremue@linux.microsoft.com> wrote:

> Compiling with MSVC results in warnings like the one below:
> 
> app/test-pmd/csumonly.c(1085): warning C4477: 'printf' : format string
>     '%d' requires an argument of type 'int',
>     but variadic argument 1 has type 'uint64_t'
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> ---

In general, DPDK code prefers to use inttypes.h which has PRIu64 macro for this.
