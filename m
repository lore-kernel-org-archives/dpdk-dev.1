Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52912D25032
	for <dpdk-dev@archiver.kernel.org>; Sun, 11 Jan 2026 06:21:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD91340276;
	Sun, 11 Jan 2026 07:21:49 +0100 (CET)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com
 [209.85.222.48]) by mails.dpdk.org (Postfix) with ESMTP id 5272540144
 for <dev@dpdk.org>; Sun, 11 Jan 2026 07:21:48 +0100 (CET)
Received: by mail-ua1-f48.google.com with SMTP id
 a1e0cc1a2514c-93a9f6efe8bso1631572241.0
 for <dev@dpdk.org>; Sat, 10 Jan 2026 22:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768112507; x=1768717307; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=+OK/08hToC/IcjEeQhb/ag1bEt8rMIctq+aV4FK3o7k=;
 b=TzYmgey5zORWcTuPTmKO7wLNWR/nP7WNa2B+tvVUmkWdfu3zSHzL5ES1xX9xmiSGRB
 S1KS+q7EjqLqmQ9SE6LV3ch5O3CDo1dRxNTHf968oNWrm/96QV7vw+2fYlXwmzS0g4wz
 QKi8JeZVTgA8JTJPqkeSAG65u2KsUrmUoNBTwWSjmz9md4SUtcISIicIMR6M26+aRYZT
 btjHJ9+0jZTGlRVgEZ9RA5a0qqfA7/GcxgOoCQFSe+PAAY3yvCttbzKqdN1YXVWa1B+/
 ov9k7fhp+epPcSFiJcXpaFs74R0TEj1KKf18h6SI6AOPpa1GyoYC5TSl66IpAtEAeZ42
 Dcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768112507; x=1768717307;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+OK/08hToC/IcjEeQhb/ag1bEt8rMIctq+aV4FK3o7k=;
 b=vfQryJYRJq2423zsawDKdGFvwMLJFB6EgDx4TW1OB+bibQqy5XVZAVi19JTMhZW3Zn
 aHt2a3gUtujiN9Sl1vjUdqHpxjLH+T4RmvN87FjSoBU9nXmHo8pIqQWvcmqHheZo9EfJ
 aw3KSw4E/7DaZCLdTOKPAWIDOpJWHl2ABAgrUGqG9gEpqxHkyilJnZgQO/2gR6Myos+J
 0Dc36jL3qiBdmu5Ia5b8Hah2I89eSmvcnLOL69FqYUurr48MhMUJ+NWOYnQEhQ5ZcD1E
 gz7FDm0lG/Sw6swi/3BTaYR0wW1Y3Sl3Obko65ozxCjvJkDahE6nJJCA3Ekh4kG8r2jz
 K5EA==
X-Gm-Message-State: AOJu0YzDn1E736I0+zyS2+0pU/D3zc6JMyuAEHxuTAWoHGnZtRniuH3X
 UCu0csqUJBVyKQnUXTpi+5ybrhsxPMD79l28nmMMJoXeUds+t8ClcSSZoGb9jD+SJZmVJPcilwd
 ydG/8Xwev+ON3H3xCmZL9oZ9v9Sj1E2o=
X-Gm-Gg: AY/fxX6f9ppD/EZgX1PLWRufORWwyIUL+k1FhWVQCKD4rqHHuZc0VQsmqyOQcqaCycq
 lqfdJSymjfIYzjy5Y0aYnhuTQTHzF324DD0ITPZDaQ8ncFdJU0pKx3CXPDLpSoN1iorTT9/+8LV
 3b2K0Hb4iJwE1QqXWXXmUIB50F+WFKZs7uj/jkfCYD1S5H95SNZ6T2hJEseUvz/uhRVDl95lfwL
 CPpCgldiCHHm4AKOStDPD59toSXYSarkKkVfg6gtBmUUAfAGBU1sP/2gZIlNh31ZXIGh5uX5gYM
 2cgH9gtzu91XxqhO7MAq3xmyeQm7HOJnelUQrQ==
X-Google-Smtp-Source: AGHT+IG0zt4G0hcKuIgwLUiJp+HKUezqrydLKA5Jo7qf8F5k8A4fKUFzjaYTHomRdyI274NRUFTR/QW2lGIZNqSE9tU=
X-Received: by 2002:a05:6102:548b:b0:5db:fe41:747b with SMTP id
 ada2fe7eead31-5ecb4f55775mr5316632137.18.1768112506853; Sat, 10 Jan 2026
 22:21:46 -0800 (PST)
MIME-Version: 1.0
References: <20260110015651.26201-1-scott.k.mitch1@gmail.com>
 <20260110015651.26201-4-scott.k.mitch1@gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65648@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65648@smartserver.smartshare.dk>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Sun, 11 Jan 2026 01:21:36 -0500
X-Gm-Features: AZwV_QiRMgBi1hoyEKO4DzBS-bt2wahpw3onX90S6rOJbhTKOwvYh6dxCcdzuIg
Message-ID: <CAFn2buCsqH5DR9k9rZFek5OyEC3q26G_Cm_u9dUG1=YuWXrgQw@mail.gmail.com>
Subject: Re: [PATCH v12 3/3] eal/net: add workaround for GCC optimization bug
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, stephen@networkplumber.org, Scott <scott_mitchell@apple.com>
Content-Type: text/plain; charset="UTF-8"
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

> Does this still happen after you replaced the RTE_PTR_ADD() with native pointer arithmetic in the checksum function?
> In other words: Is this workaround still necessary?

Yes unfortunately it is necessary with the pointer access.
I updated the reproducer which shows this case:
https://gist.github.com/Scottmitch/bf23748b4588e68c9bdb8d124f92f1bd

> This is a showstopper:
> If the workaround is necessary, applications with similar use cases also need to apply the workaround.
> If we cannot somehow enforce that, the series is likely to break some applications, which is unacceptable.

That is a great point. This API isn't internal-only and this would
effectively be
an API breaking change which doesn't seem justified.

Given what I've learned through this process (thank you & stephen for
valuable feedback)
we have a few paths to achieve my goal (clang optimizes
__rte_raw_cksum). I've verified
if the RTE_PTR_ADD macros are changed to use char* clang optimizes (and gcc
still does too) [1]. To achieve this we have some options:

A. Modify RTE_PTR_[ADD|SUB] to use pointers
pros:
- [if API can be preserved] provides benefits to all use cases w/out
usage changes
- no additional API surface to expose
cons:
- more complex macro implementation to preserve API compatibility.

B. Add RTE_CONST_PTR_[ADD|SUB] with const [void*|char*] & use it in
__rte_raw_cksum
pros:
- no risk of impacting existing RTE_PTR_[ADD|SUB] APIs
- simple implementation using pointers from the start
cons:
- API may not support all use cases as RTE_PTR_[ADD|SUB] (e.g. ptr arg
as raw integer)
- requires manual opt-in to new API to get any benefit

I have a draft of A I will submit as a patch and we can discuss if it
makes sense
or fallback to B (or other approaches).

[1] https://godbolt.org/z/5bc1bTrhe
