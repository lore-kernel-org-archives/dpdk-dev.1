Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3ACCC6B0E
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 16:04:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5940640279;
	Tue, 13 Oct 2026 18:04:36 +0200 (CEST)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id CB21C40272
 for <dev@dpdk.org>; Tue, 13 Oct 2026 18:04:35 +0200 (CEST)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4a0286c981dso447965e9.2
 for <dev@dpdk.org>; Tue, 13 Oct 2026 09:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791907475; x=1792512275; darn=dpdk.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=EuIIKDeZ32kWQSNMi4riBPjK0IgzXkKcG0ylT0UVDco=;
 b=kkBvIBvSRJ+ej8uGcIXCjCVnJVRMnIkO0t725RytyV1hxDVLHZK5ROoXRUk0FfYzti
 3du0eLerjItnRWnKggf/jBjCOVPEXIVblKaYT0I1fS6MKvn6I6V2JVUoS7mWjYFchN0h
 ddagz79h9XqWYKXlK5QZcWkCuniFsj187VJQKQeSYdtU5UJCwyi3+3iOxXhXqgkLqX5G
 XbT+OVxAgv6HyqzIsxLzj7TXyvOjbhNE6MP8pL+GSeBjzDhX2gxpbAf/8XUI1uVtYRE6
 iPqAnT1VI8pfMKjQa6vhDnwB2awNi66Ek39Ffu59ROrIVl6iKLGDKCMOxZ7IEYLbWpZQ
 wn2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791907475; x=1792512275;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EuIIKDeZ32kWQSNMi4riBPjK0IgzXkKcG0ylT0UVDco=;
 b=ZAftSM2pVBLxv1N9zFufBwacsnwKfIHhBQC8GKYp0J7B7wkG0Jvcck9IhzN1oza/3I
 puc03UQli9RkZdLR9dpREPCd9DoTTvV3qGJqb7c48Se6dW/NPBoK+yNgp55GTb7nkYVs
 v5jgepFAfmC0ds5MHPAhjvCoqUfSareapYPwpyfP3RqpH50zaULCA2IANsmW5IHnX1ua
 fTQoDR+ZbA+pFG8YrKIhyhaiVKhE9kSBF3mU9Fg+1nLQ1YicbAa0BXd5n6a9kfKW8wsX
 /+UKnFZ/4MYctGJZqPA99zq7brjnta/AJWh7/zoGKxbVpJMqd4N6BTDdxefl6SJsm/Ee
 u4mQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBy0gpsNWk7U82ev/xi5CNRyH7ov1XUFClFdF2anTGSU/CFSET83W5e1kEWmDM8mEnTM5vY=@dpdk.org
X-Gm-Message-State: AFq9FYKVeWRH9minXNtXh2OPaI3vmM2Gb7J6do01B/Js3gUafR+YmM3Z
 4UoPOxzPL1K1hFkueejo9EqMPXRj7omejy81qvfYwsI3UF7tG4if4WoF9VEpR5iNHQ4=
X-Gm-Gg: AYBFou03UthyN5roKwZctwYlhhmGkqb4c1toRyppW/0W6OD4CuqLnpSKdf3ppASdgww
 TtpDEWCxfwhDNm9JPonqH1wG9VDRDtdlooYALCPv62iZp+7jkutvxXvWJxvebJk/Jd+ZlAIi05Z
 8KUjUSIXRgFJW0tQq+Qw2TNkoaJwBFchIARcraJCsgFaYVH283E1xTzTMTTt9GOY4s7V2FooTf7
 5emZ7olS8ewYYPAe9iUT326xOtw+0n+cCWuiXKX90fwuegreoycnIFN9EuXRxWyNxudJUMFiu6Q
 eNGR/8QR2TCiIHuA73+0H5G8ctCMZw5rNHVLWm+ioznp1wzOgR4T5fIPYghzWApJ1Zl01IX7iDz
 9qSF8TZQ0FFzFLUTfAgm5WoAkrLsM9P8c9izoQXu0aHaflLuic0MXyTcevwQwU3L9HvF04B9+XX
 ekMXVpqCpmN0oJnyvW99a6fGIL0bkWuM5Rs53L5nY2CzvPV3RgF7Fyh7kb5s+Bkznhl4M=
X-Received: by 2002:a05:600c:3e07:b0:4a1:8627:aec7 with SMTP id
 5b1f17b1804b1-4a18e4987abmr220064495e9.5.1791907475093; 
 Tue, 13 Oct 2026 09:04:35 -0700 (PDT)
Received: from [192.168.0.78] ([80.233.42.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf15691sm366082245e9.6.2026.10.13.09.04.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2026 09:04:34 -0700 (PDT)
Message-ID: <31fc3286-242e-4104-9247-330a3d1ce217@gmail.com>
Date: Tue, 13 Oct 2026 17:04:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/29] bpf: replace deprecated SMP barriers with C11
 fences
To: David Marchand <david.marchand@redhat.com>
Cc: Wathsala Vithanage <wathsala.vithanage@arm.com>, dev@dpdk.org,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Stephen Hemminger <stephen@networkplumber.org>
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
 <20261008233649.1260843-2-stephen@networkplumber.org>
 <b9d3cb13-e34f-406d-ac18-345fede8bc5b@arm.com>
 <6888e84c-e250-4ed9-ad70-46178014eb15@gmail.com>
 <CAJFAV8zWR0PPrSNzwMyP=2wFFTpjCq4dWFs9X0HSjkCNXVF2mg@mail.gmail.com>
Content-Language: en-US
From: Marat Khalili <qm2k21@gmail.com>
In-Reply-To: <CAJFAV8zWR0PPrSNzwMyP=2wFFTpjCq4dWFs9X0HSjkCNXVF2mg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 13/10/2026 08:54, David Marchand wrote:
> This blocks the SMP barrier removal for rc1.
>
> What is your proposal?
>
> I think it makes sense to take
> https://patchwork.dpdk.org/project/dpdk/list/?series=39599 first, then
> resolve the conflict for the patch from this thread.
> Is this BPF series ready for merge?
>
> If it is not ready yet, what should be done on the current patch?
> Is a s/rte_smp_rmb()/rte_atomic_thread_fence(rte_memory_order_seq_cst)/ enough?
> The commitlog would also need some rewritting.

I think we should be able to unblock this patchset with the diff below. 
Last version contains some additional out-of-scope changes that might 
not be helpful in the long run, but I tend to believe Stephen and 
Wathsala that they are not breaking anything (I have not checked it 
myself). If the version below is ok with Stephen I would prefer it 
(consider it acked), otherwise I can withdraw my NAK for the sake of the 
release, at the cost of some potentially confusing noise in the commit 
history in the future.

diff --git a/lib/bpf/bpf_pkt.c b/lib/bpf/bpf_pkt.c
index f072fdaaed..0d0c37cdc5 100644
--- a/lib/bpf/bpf_pkt.c
+++ b/lib/bpf/bpf_pkt.c
@@ -82,7 +82,7 @@ bpf_eth_cbi_inuse(struct bpf_eth_cbi *cbi)
  {
         cbi->use++;
         /* make sure no store/load reordering could happen */
-       rte_smp_mb();
+       rte_atomic_thread_fence(rte_memory_order_seq_cst);
  }

  /*
@@ -92,7 +92,7 @@ static __rte_always_inline void
  bpf_eth_cbi_unuse(struct bpf_eth_cbi *cbi)
  {
         /* make sure all previous loads are completed */
-       rte_smp_rmb();
+       rte_atomic_thread_fence(rte_memory_order_release);
         cbi->use++;
  }

@@ -105,7 +105,7 @@ bpf_eth_cbi_wait(const struct bpf_eth_cbi *cbi)
         uint32_t puse;

         /* make sure all previous loads and stores are completed */
-       rte_smp_mb();
+       rte_atomic_thread_fence(rte_memory_order_seq_cst);

         puse = cbi->use;

@@ -439,7 +439,7 @@ bpf_eth_cbi_unload(struct bpf_eth_cbi *bc)
  {
         /* mark this cbi as empty */
         bc->cb = NULL;
-       rte_smp_mb();
+       rte_atomic_thread_fence(rte_memory_order_seq_cst);

         /* make sure datapath doesn't use bpf anymore, then destroy bpf */
         bpf_eth_cbi_wait(bc);

