Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CA2F54ACF
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:31:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 085E0402BE;
	Tue, 24 Mar 2026 17:31:51 +0100 (CET)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com
 [209.85.222.47]) by mails.dpdk.org (Postfix) with ESMTP id 668844025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 17:31:49 +0100 (CET)
Received: by mail-ua1-f47.google.com with SMTP id
 a1e0cc1a2514c-950c41532e1so2995713241.1
 for <dev@dpdk.org>; Tue, 24 Mar 2026 09:31:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774369908; cv=none;
 d=google.com; s=arc-20240605;
 b=Qz4dSZo8mfOB6c1lmQxpQHl+iusEGF0ckXblWG2vCe9KCvm4hRCnD0aGfAzrz7Y8py
 O5r3rq2VEDON350MKFEMiZZreUY6pG0qS2+5WLduykfcsxSz71I76zmDl7CRxejHu08U
 EgCAxWen11P0Yq2b6ePUQylZZKbNWxZXwrPS0tuvlDCs3MpfL8dQXbpDwRHbqaWRVjLv
 0JEIfjHTXAWfEX5TrEOUJzdGSyLMHhXgVqwzEs79kU89l3d+WuJiKxidDQYMWuda0hCm
 qtOGdlXrvij3Rv7iUZ3Baw/ez/rzkDMlzJvEdkb0V4bzM0+hdKvm8ixine9T/jXPlLWr
 UPyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=W6TymSVDlGUAah+ZW3jBNsJ4KF2VKeGeoux2XH4TcEM=;
 fh=Wh/NfB5Oag2yR58rVkXgIlXDFD+lJgjkZZq62H5EQxc=;
 b=ROqrE8c6q+hIG6B8sq6WtN1R7Gc5EwyA6cQN4s2AXfxOW2j/p0U507ORhuVpGuqWIk
 dazwD6nHHoGZ6b43oEYcBMV+aejiWGvKqagxqeSJWmz72lADMaAbHGQ3TLZenPHuWbsO
 5alXJGolouGi0c9eS1dCnHM1QsmJfK8FTeKhdJ1YiTTstI+aFuGiGFnfsHqGuafenHTb
 wXeyxwyJ85h2xsJYNgSXVMZVFsGZyGxIg4XoC461NcrJFtl62kKccdWCdkb8E16IwK/N
 /KeLjLSpkEzUQgSYbAG8DeCyjTwuKm4k+vbJLrGj81lOxUXKaaxUbrLTiiwHgL64S3ap
 Oq2g==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1774369908; x=1774974708; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=W6TymSVDlGUAah+ZW3jBNsJ4KF2VKeGeoux2XH4TcEM=;
 b=GHZZ/QeXcQWMd/WvZAk26f/EkyaMz1rQ6NE6gqGP3rNfZ8VZ9za+o62SSL/JV80caY
 lEqwgEOXv4ijPblV96FQbZknJroiLJ+K7AuEvCEbAIPx8A6ZGNf28Rno530Zvu6Kz5u+
 mDp8/ZbV9v4mZxEMVVXdQglWqmhdzsR+T3ICQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774369908; x=1774974708;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W6TymSVDlGUAah+ZW3jBNsJ4KF2VKeGeoux2XH4TcEM=;
 b=VMV9EmNFdbj7+0SDv+f3LIvUyvBDvizYDT/0uRppEYszEdev0FRnoXG8CwOYgmwEMY
 5A6PzmsNCeigvMUzldDG/U/ZChDxRzQQdA9Zkfe3NsxUToEK763qtA/rm3QOhzPNMlM9
 RnGA4Qci9qNhk9rdrL4dbymTZtfzpMgyNwG570HnIzV6ITcpGoW+e6qy+McpvwokLzdc
 qGPtlAG+1gqFYEEA04ICr+uxPZXzcZ8mhOiiPC3dV4MW3TGQ5/eyIab4B1f4qAxWP9+6
 AmpAEyhNPnwMxGGLdAI5RH/hjXQDFtjop6q5nEKmQCzBb3agqecac1JeZRFkHVdONbGC
 GG0w==
X-Gm-Message-State: AOJu0Yy7+/r28QOYEyV1OSAr0WdtqopsRdHDYmLcPQGsj6kK8+gRbI5x
 qn4YtllHwab+fYTnoEPcjD4nVghhkh/+YYqrCs911fBbAbZMFGlgrabnmeLWBfPA5Sb3320i7/t
 2NBerNr5RUYtmkmqgZ74gaADx4OfHSLRM144uJePcdg==
X-Gm-Gg: ATEYQzxVrYpnHnzgMtUEXmPLqFpclVCcnY0JqKNkQCCOb2pyPo1iXyPWa4sIsjXmfpJ
 zMolcWHYnpZG6+wTLDpDuVlJX/zsoi01WG/6gDqzrwO63CTXVycAlktd9KGP8ttAGZ+RfiSTdhg
 h2HpnDBWKqPNvnWfQEp1XZXUDfIe+x/4NcLB7QxJGCIh2RzbpqAIIYUif5FD6zs4ciYAuJ5P/eC
 01F4vWhtsJuv5w5iObkB+cJ5Hv/gVPghDWnZbe2w+w1SiQ97k8KNHSg4cUATyuI3n/gbHRzkCiM
 4WnYLjz+Dc+9AiA5BEbij37zbhhSiuKySV3Qx6IXuhYClA+Ug2UxXQ9Fi7Y2OFHZBNzz5Lwl0I7
 2R/PRgwAclT8shZ/G31yJsacFsgtEG0De+pZJpLzGrhduXCdXzUlqDyQfvBdyJD+kaoCeFA==
X-Received: by 2002:a05:6102:4b06:b0:602:7589:6545 with SMTP id
 ada2fe7eead31-603872c7408mr306783137.28.1774369908667; Tue, 24 Mar 2026
 09:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260319171334.1151425-1-bruce.richardson@intel.com>
 <20260320161108.331745-1-bruce.richardson@intel.com>
In-Reply-To: <20260320161108.331745-1-bruce.richardson@intel.com>
From: Adam Hassick <ahassick@iol.unh.edu>
Date: Tue, 24 Mar 2026 12:31:37 -0400
X-Gm-Features: AQROBzDljZNh9KdqMiegTZ7G4IzoBuSKuDHeWcoiwCNYfQGbz15S9olCaewYZx8
Message-ID: <CAC-YWqgoK0K8LooR96bdrJe8iYP8j22mWSD9wc0g3npr3ADzYg@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Get fast-test suite to run on FreeBSD
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, david.marchand@redhat.com, probb@iol.unh.edu
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

Tested-by: Adam Hassick <ahassick@iol.unh.edu>

I have posted a link to the unit test log on the ticket.
Related to the issue Patrick found, where Meson raises an error, we
are running an older version of Meson on our FreeBSD system (0.57.2).
