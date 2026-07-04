Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B5CBC43458
	for <dpdk-dev@archiver.kernel.org>; Sat,  4 Jul 2026 16:09:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 711BD402C6;
	Sat,  4 Jul 2026 18:09:24 +0200 (CEST)
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com
 [209.85.216.45]) by mails.dpdk.org (Postfix) with ESMTP id 1D6EB4021F
 for <dev@dpdk.org>; Sat,  4 Jul 2026 18:09:22 +0200 (CEST)
Received: by mail-pj1-f45.google.com with SMTP id
 98e67ed59e1d1-38175907a56so865940a91.0
 for <dev@dpdk.org>; Sat, 04 Jul 2026 09:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1783181362;
 x=1783786162; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w+ihF904RfT36MNUfeoBYZYns6sGNmxKf0r4uOV45AU=;
 b=ivp4gMD6WCF2fojZODBOaJZnN+dnE0EYIE4vDlR+WGVcvyJYkPrg7g40NQo7aJHCAb
 s5tvf/CuoyhtX0uCndjP59gcbXbtQeyxZ5WAbqbaEfhXRWu+7IW6bYeajNzSFZ7tu58O
 x8Vp+B8Amoxj+NBRAAubyFW+vwV8B9o9D8nGewypIY/jBo5g46WameYUy+eAyVrbruO9
 AB7wGECZjS7cHJZPuvQwhVqjI35HDjUvtzkBTZlSlf1KCOzJ/gvVYkWb4qwxA2LL9U6n
 S/JaxVLjoSVWCdKmbL0wRXH3+mBLJqMvjaLvP2rHEJGUPOK0p9t/e1mSw2m2RGJ8rNBJ
 1vdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783181362; x=1783786162;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w+ihF904RfT36MNUfeoBYZYns6sGNmxKf0r4uOV45AU=;
 b=YkvU996lyBoCn1dPo0ctzGM2xebWVLGSSvNLdko4/pfSIbmPnEWGJGjRbo2z7l+jSn
 xNQFV0weUKzfVkmmOAbY/7awpfTAXSsxB9c411KkiKm3OL75sMFtvr4wjvwB7ws/gxsv
 zL8G4k2HY+e58Y/SuG05wC5NUQC9BfJ/gDQaz9XUYZqYBa2KFR5tU4Bh3+7lL8Ktv9An
 2nxVvEmbmc+WTz9YKo1IDfAK5ZgvUsU5pNG3Wk+223zyAXhJh1Dw5iIpontT1ZNGn0xC
 8vGwTQS8nbIyu2+GKJXE/3RFe2rYefegItxuyAollbVKg6rS6WUtKEYtdDoTn70HD7FK
 Y1zg==
X-Gm-Message-State: AOJu0YyOEG2tnvryaFTNEbvJnjeDcK2UqGgZK3cVa454qNq3+som4WLg
 1lvChK9+isZ6cGxxc0j75mTE0wTx2jOhVF5q2kliiIFm2K472Rc7uxoiU1ZJeupflUE=
X-Gm-Gg: AfdE7ckhaKDnbVPiL4HOHFxQ1yoZpyzEIP79y/KJa4I50B9gfzGCYqU3wVYqr5775rF
 8h9EAmuZFrcb5cvSQs4f9T5zPS4T1/Q6ucgkHuFk6k/uvkWnaAWBH/pLHK1R9tmGm8BvUsmItZe
 QGoxWHU6H0xMAab0hFbAuFFuhVUnfniSfz+9hDF5RRLyetYySO3dpn2cOghBn+/1j6R/Omr395t
 FHJTtUZYaT0lU+85Dx1Z432Dd1bHoj9Am69pO4lkMhozTPZB3rJEF7tOxCTBo0nEqh/ILPupZrL
 1jn4zYjuwpGvUWxdcnFYIn67Tp6Sy+sEs5EBvZr6onOAey79mgj9WhZrDFjhVFDsasfZtxGp5U1
 E0Tho/qGXn+FC6sUqGhg7nnGFMAdnqKgsw30uotEXJsq8Yw6XN3cN7kGFU9MPspH9gA2lhMJr6/
 8x9+SEKQI/msEJ/70MZAXgTAZSflNpSUV31BBZm97IjU01lEht0m+KBQ==
X-Received: by 2002:a17:90b:528e:b0:380:9699:ae98 with SMTP id
 98e67ed59e1d1-381120f7aeamr9898537a91.8.1783181361804; 
 Sat, 04 Jul 2026 09:09:21 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30f3a9341e0sm23707034eec.12.2026.07.04.09.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 09:09:21 -0700 (PDT)
Date: Sat, 4 Jul 2026 09:09:18 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Weijun Pan <wpan3636@gmail.com>
Cc: dev@dpdk.org, chas3@att.com, humin29@huawei.com
Subject: Re: [RFC] net/bonding: support limited datapath in secondary process
Message-ID: <20260704090918.04fc3ec7@phoenix.local>
In-Reply-To: <CAMEmXsxzEfsu1boqPrYtTbuf3j9VM0vb8JBzC-NKm4YXJFVPNw@mail.gmail.com>
References: <CAMEmXsxzEfsu1boqPrYtTbuf3j9VM0vb8JBzC-NKm4YXJFVPNw@mail.gmail.com>
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

On Sat, 4 Jul 2026 11:00:42 -0500
Weijun Pan <wpan3636@gmail.com> wrote:

> Hi,
> 
> I am looking into Bugzilla 1900 and real secondary-process datapath
> support for the bonding PMD.
> 
> The current secondary attach path is safe by default: secondary Rx/Tx
> uses blackhole burst functions instead of installing real per-mode
> bonding burst functions. This avoids crashes because the internal
> bonding state is not valid in the secondary process.
> 
> However, this also means that a secondary process cannot perform real
> Rx/Tx through a bonding device. This is the issue described in
> Bugzilla 1900.
> 
> I would like to discuss whether a limited secondary datapath model
> would be acceptable, without fully sharing all bonding state across
> processes.
> 
> The proposed model is:
> 
> * the primary process owns the bonding control plane;
> * the primary process owns the LACP state machine for mode 4 / 802.3ad;
> * secondary processes cannot change bond mode, add/remove members, or
> enable/disable dedicated LACP queues;
> * the primary process publishes only a minimal shared datapath state snapshot;
> * secondary processes only read this shared state for Rx/Tx decisions;
> * blackhole burst functions remain the fallback when real secondary
> datapath support is not available.
> 
> For mode 4, the shared snapshot could initially include only the state
> required by the datapath, such as the active member list and
> per-member collecting/distributing state.
> 
> This would make the secondary process a datapath consumer of
> primary-maintained bonding state, rather than a second owner of the
> bonding control plane.
> 
> Questions:
> 
> 1. Should real secondary datapath support be considered at all, or
> should bonding secondary support remain limited to safe blackhole
> Rx/Tx?
> 2. If real secondary datapath support is considered, is this limited
> secondary datapath model acceptable for the bonding PMD?
> 
> I would like to work on this if the direction sounds reasonable.
> 
> Thanks,
> Weijun

It would be great to allow secondary to do Rx/Tx. 
But it needs to be safe against primary changing datapath.

The important part is that is better to return an error or blackhole
data rather than causing crashes. If you require primary to do all
control plane; then all secondary requests need to return an error.
