Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375F0C5AD5A
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Aug 2026 02:04:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4FD084026E;
	Thu, 13 Aug 2026 04:04:31 +0200 (CEST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by mails.dpdk.org (Postfix) with ESMTP id 1D29A40265
 for <dev@dpdk.org>; Thu, 13 Aug 2026 04:04:30 +0200 (CEST)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2cc97653887so3984235ad.1
 for <dev@dpdk.org>; Wed, 12 Aug 2026 19:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786586669;
 x=1787191469; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=71v8F3yBcrtIjsn+DCtubU+OqnMf51EitJHa/uIbMC8=;
 b=rn61I1lztp7Ls2KumaGnhhp894gFB37DJdx4vU9boc+XXheuZpdM/yAI5Z5uExZXxs
 41Xyxw+lj/xf1sDNSej7uy0ZndLxLr9PzWvP4od+KceW78fCjkyZhCIor5xPB1ep4ghY
 b8NhLwOlNNP5mldZqr8e7WXtPsmdrHU5oEjGFrwCQeOOinJKmS9SaCp6dae8F3jIdwYs
 ejnh2dTAwarnOtkvAB+UFGQj1D9idnuFpXLDMhsTJHl4CQbiLrEEnVbVXJcGRSbSqVkm
 b3x7R8BoK/WL72xXx60Givgb7bHyizboWPswzveJySH2hPJy6coWLz2HsYA3AmuuhH8B
 tnlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786586669; x=1787191469;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=71v8F3yBcrtIjsn+DCtubU+OqnMf51EitJHa/uIbMC8=;
 b=PaBz8lZPO3mF99Xfv8+z4+2NVUErK1vIafK+S6rjN+zmv4GUZpwAYjFFU0ySp8z/JW
 waJC2aYk/ZddMMDGo9rgUQfp0fgqau9ktFR8M+j66mCnzza/3cYG3Jmiu6X2oF36gVcE
 Bz9Y+tercDcWmm+qnP4HgBoi4E0kVxP9FGWR+mT1Rms3oljivD6HWq1OoQwedZldjCHA
 +OKXgTunPRoCkPMVqwjdxFl9usmJlrGFc0Xe67HeXmRJVsGYQmmcAu8LOE7nJOc2DSso
 c/o8Xur+N9Wan5n++O89lZUTAvSxcZ6CORun+C3KPJfgP7xnzLfOQqZnGohKv0Kv5/fM
 +Zqg==
X-Gm-Message-State: AOJu0Yyb3D8hOejFGU4HT/qv3PQLQ9F/z9yft34Bdd8/OSP0bxvkgS9B
 qHNVzjqkMJCzrYLeHtlnAE2KC6+2ZHy5V+NRM+shb3/1/bRJDcN6QdycrLfZ5Y1jiQI=
X-Gm-Gg: AR+sD12MAZHdvj8ayqt+RIDSTX9pwBqyjZFIywOONMrr1nMcK4Dql3b96qjpbc6p13O
 ux9IhoXR9BuXbZRV8ck06z3Zg6dmPn9fD/I0EODOvi3dL/S2+lJ6pdOnuaZg4Nd5axvzcMcdRTN
 2Hp1KgbHEDNGM8lFN8DxMj21kWLw817omhNZTr12Ngpp/eOhGoCS/Ics3iGK5ChZdnlfKGX3aVM
 WlhQDviHiwAYVZsOLIsZDGr6QqOLWYr84pqwjfi8Uc89Fv/1o+El+bmOmeRcFkiB/yaDlHE2pbk
 aGapbShKQVHNqV0eJ6thD6eJjj7dq3yWpoCZSIF5PFLfZl9OIo48pmrWkAnFuEI6D3oZY1mUFcF
 D9/VKTGeFRYbg17bxPWxNSsi+HIVp/9RFUs7niWZpF0CBNM9klGVc/VITrTF6NfPxoDPEMipbzg
 dbokQjI/4wLlidehyaV+EtCN8NAVjEQkb5EmUaRm19oZdsbdpZ86EwJp+5IRaqqQdCZWRPj9KPs
 XTknSevvYfAY4H7Y5ievpVfa9XGbWiI62pG6k8s
X-Received: by 2002:a17:90b:53cb:b0:381:1c96:829b with SMTP id
 98e67ed59e1d1-3931e0241cemr3301024a91.3.1786586669009; 
 Wed, 12 Aug 2026 19:04:29 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1412d8d0c3esm3531145c88.6.2026.08.12.19.04.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 19:04:28 -0700 (PDT)
Date: Wed, 12 Aug 2026 19:04:19 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anurag Mandal <anurag.mandal@intel.com>
Cc: dev@dpdk.org, ciara.loftus@intel.com, mtahhan@redhat.com
Subject: Re: [PATCH v3] net/af_xdp: fix default device plugin path
Message-ID: <20260812190419.30aa922c@phoenix.local>
In-Reply-To: <20260812014742.1124468-1-anurag.mandal@intel.com>
References: <20260810101158.1011356-1-anurag.mandal@intel.com>
 <20260812014742.1124468-1-anurag.mandal@intel.com>
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

On Wed, 12 Aug 2026 01:47:42 +0000
Anurag Mandal <anurag.mandal@intel.com> wrote:

> When use_cni=1 or use_pinned_map=1 is passed without an explicit
> dp_path, the PMD builds the path to the AF_XDP device plugin
> endpoint itself.
> That default was hardcoded to /tmp/afxdp_dp/<if_name>/.
> 
> A unix domain socket and a pinned map are runtime state.
> DPDK exposes a location for such state through
> rte_eal_get_runtime_dir(), which is per user, per
> file prefix, and created with mode 0700, unlike
> the shared /tmp/afxdp_dp directory.
> 
> The location cannot simply be moved as it is a contract
> duplicated in the AF_XDP Device Plugin for Kubernetes,
> which creates the socket and mounts it into the pod at
> the /tmp path the PMD expects.
> Changing only the PMD would break every existing deployment.
> 
> This patch fixes the default so that the endpoint is looked
> up below the EAL runtime directory first, and /tmp/afxdp_dp
> is only used when nothing is found there.
> Use of the fallback is logged at notice level.
> Existing plugin deployments keep working unchanged, while
> a deployment that places the endpoint in the runtime
> directory no longer has to pass dp_path.
> An explicit dp_path still overrides both.
> 
> The <if_name> component is kept in both layouts. It is what
> keeps the endpoints of several interfaces distinct when more
> than one UDS server is mounted in a single pod.
> 
> The runtime directory prefix makes the built path longer,
> so reject a dp_path that does not fit the sun_path field
> of struct sockaddr_un instead of letting strlcpy()
> silently truncate it.
> 
> The interface name check is moved ahead of the path
> construction, as the default path is now built from it.
> 
> Bugzilla ID: 1973
> Fixes: 9c1323736cf9 ("net/af_xdp: fix multi-interface support for k8s")
> Fixes: 8a324b1c6464 ("net/af_xdp: support AF_XDP device plugin pinned maps")
> 
> Signed-off-by: Anurag Mandal <anurag.mandal@intel.com>
> ---

Applied to net-next. I went ahead and cleaned up the release
note and docs. There are still some nits that AI is complaining
about but not really worth spending time resolving.
