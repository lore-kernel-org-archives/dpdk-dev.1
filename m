Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC86CC6B03
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Oct 2026 07:55:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7CF2740272;
	Tue, 13 Oct 2026 09:55:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id CB2FA400D6
 for <dev@dpdk.org>; Tue, 13 Oct 2026 09:55:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791878101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dc9mx28yJ4JfXOFSRa0+rp9miK7YsS4XoDaKMahSOFw=;
 b=CduPSyQDj4SPlW/FzACPbFovCRUwka15kBEiMV1DoKhrwYPGPL3OyXyZ8NmY3JnCvsGo8k
 E1FddcjK00ITXi7uL8xq95j2/wEAnU9TaFl1Q4SAyJ8+nYvUwWuJDzdf2hH/o5k2qEWcPt
 ig+zZUcBKYhfS7xmMlyzTVEx8VfvkjI=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-sqNal31vOICmUkJ4MUoFVA-1; Tue, 13 Oct 2026 07:54:53 +0000
X-MC-Unique: sqNal31vOICmUkJ4MUoFVA-1
X-Mimecast-MFC-AGG-ID: sqNal31vOICmUkJ4MUoFVA_1791878092
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5ba3b187b35so1769407e87.3
 for <dev@dpdk.org>; Tue, 13 Oct 2026 00:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791878092; x=1792482892;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=dc9mx28yJ4JfXOFSRa0+rp9miK7YsS4XoDaKMahSOFw=;
 b=atpEJjnXI0533ZUkU+SFHs5mgxzyl/KuErsIVfaR6fpV+zOvtO11A86DJfxyMl90qE
 RYxfpmXdolxBhMd5mdPcRim/muudzaoMksJCdrzBsHJePNYJNax4TmiA18b/FXldqxZ1
 LdblRev4I2sK1P5VOwITHKxdxogrf35fxTVW9CIZNRD4u/XspNG9EKLtBW84RAXOxERx
 MUQ6aFKIQ5/PCrwJ6KyCT5QJJRLjA9+g7joaynFauadah9JFM+9uaH+BVfGSmJdvSH84
 finrEjRGzIIfBQT3iliczauZ2B2hb4YyQuFdYnOBw9i95QYISuAMKfbvgW3cqgWfH+3C
 YClQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxG/hQxhklDIq5+rM1r7oRpb+EUzu1rNWGDDNSfD4nm7BLhJ1+ojaZt96IcB4A05CCG5GQ=@dpdk.org
X-Gm-Message-State: AFq9FYJKFH2dqFaiIBo5pj9sq8wpE8kIIbAUx2PfZNX938tp0BpHahmy
 +dfc369JGqDyUKG9ZolBYsEgj0wPGVCkvEI649Kb2w9kaFzrAn7sXsx3796RJNwswmwRmUGK3H+
 m+zWMCz0u5Tobo6B/bi2VdMhoyFb99p/QKiwf5VvuH4h9OZ6FSLyLE+WJUGjgl6xF6wzlkv1aZk
 IFhxhJbG1awr+iRFIEFdw=
X-Gm-Gg: AYBFou018fy5w9VfGBURjmJHBiXn1ASwp5YSzhEPft8v9KZhX3ZqH4crmkgeHaAIzH4
 x4Dzfz0rEsTiG7tzg4sNzBG6yyB7GtH9JXQDamIs11UOQJfdp6aMlidWHK4rMsdfup9K9r7C2NS
 rHwOpde+MVoP3wti/3IBs0lC7Byd8NmlyZr2DFRw83Gexq5qpBktHAPBDwmRskPKYvoIVzQyjGW
 5GOiL2A9qCOwDg9SQhc/sX1qQq3t+zB42nrzYpiAi2IV9yB
X-Received: by 2002:a05:6512:3d8a:b0:5b8:bc5e:b58b with SMTP id
 2adb3069b0e04-5bcde8e872amr3616988e87.67.1791878092147; 
 Tue, 13 Oct 2026 00:54:52 -0700 (PDT)
X-Received: by 2002:a05:6512:3d8a:b0:5b8:bc5e:b58b with SMTP id
 2adb3069b0e04-5bcde8e872amr3616975e87.67.1791878091702; Tue, 13 Oct 2026
 00:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20260729175715.165120-1-stephen@networkplumber.org>
 <20261008233649.1260843-1-stephen@networkplumber.org>
 <20261008233649.1260843-2-stephen@networkplumber.org>
 <b9d3cb13-e34f-406d-ac18-345fede8bc5b@arm.com>
 <6888e84c-e250-4ed9-ad70-46178014eb15@gmail.com>
In-Reply-To: <6888e84c-e250-4ed9-ad70-46178014eb15@gmail.com>
From: David Marchand <david.marchand@redhat.com>
Date: Tue, 13 Oct 2026 09:54:38 +0200
X-Gm-Features: AclHuK_eJ85RBXvlKZI_xRyHNdLG4Q4BWPJXoMN1CjBE3ih7lqsxJL_F8G_Hrjo
Message-ID: <CAJFAV8zWR0PPrSNzwMyP=2wFFTpjCq4dWFs9X0HSjkCNXVF2mg@mail.gmail.com>
Subject: Re: [PATCH v3 01/29] bpf: replace deprecated SMP barriers with C11
 fences
To: Marat Khalili <qm2k21@gmail.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Cc: Wathsala Vithanage <wathsala.vithanage@arm.com>, dev@dpdk.org, 
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nbQKvG1U_rRnzCvuaLCOPhwDIQUakcBpklfPD7SVkKk_1791878092
X-Mimecast-Originator: redhat.com
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

On Mon, 12 Oct 2026 at 20:53, Marat Khalili <qm2k21@gmail.com> wrote:
>
> On 09/10/2026 07:05, Wathsala Vithanage wrote:
> >>   /*
> >>    * Marks given callback as used by datapath.
> >>    */
> >>   static __rte_always_inline void
> >>   bpf_eth_cbi_inuse(struct bpf_eth_cbi *cbi)
> >>   {
> >> -    cbi->use++;
> >> -    /* make sure no store/load reordering could happen */
> >> -    rte_smp_mb();
> >> +    rte_atomic_store_explicit(&cbi->use,
> >> +        rte_atomic_load_explicit(&cbi->use,
> >> rte_memory_order_relaxed) + 1,
> >> +        rte_memory_order_relaxed);
> >> +
> >> +    /* full barrier: count must be visible before cb is read */
> >> +    rte_atomic_thread_fence(rte_memory_order_seq_cst);
>
> NAK: optimizing this increment makes little sense when more careful
> analysis shows that it can be simply removed.
>
> I highly recommend keeping this patchset dedicated to removing
> rte_smp_XX barriers and moving other bpf_pkt.c improvements elsewhere.

This blocks the SMP barrier removal for rc1.

What is your proposal?

I think it makes sense to take
https://patchwork.dpdk.org/project/dpdk/list/?series=39599 first, then
resolve the conflict for the patch from this thread.
Is this BPF series ready for merge?

If it is not ready yet, what should be done on the current patch?
Is a s/rte_smp_rmb()/rte_atomic_thread_fence(rte_memory_order_seq_cst)/ enough?
The commitlog would also need some rewritting.


-- 
David Marchand

