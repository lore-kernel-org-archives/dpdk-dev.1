Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED67C5B572
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Aug 2026 17:59:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84866410E7;
	Tue, 11 Aug 2026 19:59:46 +0200 (CEST)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id BD98740E18
 for <dev@dpdk.org>; Tue, 11 Aug 2026 19:59:44 +0200 (CEST)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-cbee3777e1cso35864a12.3
 for <dev@dpdk.org>; Tue, 11 Aug 2026 10:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1786471184;
 x=1787075984; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=PHhKSCreMIFLX0GH37A5GByEoPnSrxx2bWU0ho7bVUc=;
 b=A2Tuz0IbECVPeovaZokL0sqpjFiNCXg7a/1hn84On2WE2JK/t05577CqnoAjd9sd4b
 xhNFtZrD5guynpau2Bx6CY+KVDxk9YlOS9zP0k1ZRcfNARJhPVaZA7BkIXkjUUEV5XPW
 UtUFNOanxLnIoDuZhym4fYs5qXyWCDOCg1+2ziIx58gi+rVptgJspCFy51xVSQQ4bj7Q
 ks+Lba83S5FfotM0AqNdIFw4QM/mNhcf1v5qegkUJnbqKNY0vczSBDghlJpr64bofs1M
 thrmhhOll8VKtgHScutIyQpzgsI5aPDZt4SvuURcAUgcevneKksqeeJPeOEOKk1KJiOb
 pSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786471184; x=1787075984;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PHhKSCreMIFLX0GH37A5GByEoPnSrxx2bWU0ho7bVUc=;
 b=P/VVHb86jOALQrjJ0GSLe+f/KDVIxgNFtzqhQC+KJ9fbvckfaqdLf6FsUSU91rh6QA
 lkk/pMFBqEESoRGmqz1+BEekRJkccRl+UvVIu0n921rQWZro0O3gndFMXZxaFg0k3aeT
 dJIl/HhkY4O/nPeZw2PC8O+hNMayYRiP1WBt+Ehc//DGx/kdmGGJAN7B3kSEwYsC1guh
 vzA7r5ygVz/AsWs7lnZ+mAM4W8TVLpD98Gv/FQTjGXpY9geZs7t4luuk9KLt1PDHzqXi
 DmfGwnZqFeEYEi+PLjnCaX96Q0jttPHeFymebI9++vXtFCDQ+PD8gSGQlMbjGUIzjMld
 MVyQ==
X-Gm-Message-State: AOJu0Yw4QbjCgBrHztg0qpGkyGDVESs9U0eKvzRLA+pBTNPMdx7ESuwn
 kDRpOQ3aPdEae3jLEQVY+W6X5IZCtF9uA6nlv1dRX6DkZUhGDAFljTyAq8887N8cJd4=
X-Gm-Gg: AR+sD10Bv62dhd25rOnDDamTZnJlUhF5F6PKRQM6xjIQ/EP2CXvfT8MQEkJOo1okoHr
 CSogg7JDY4W0/1eSvi8A4uuWPiTvFXhFmfxhA0FodC2fsP+HdWX5mzTZ6YaNa1Q9u/cHK9Gf6X1
 c9T2sDkZt+RkUl/gp+Zn3+oV5z+pyVBiPMoS4vE7JFC0VUQp8QKPkds4BLbeKv488p7bqvz7hwU
 13D7t85LYywJ7IMwmbwojv+0GkeznxdiFFmmWUByw2TI36qQbtqbdD6cJddAxsht3t//GvbcZQf
 z0y4Pm8ST+Hy7EeE4ONuGmBIt4xtY31U22rjlHrHaOr4HqBzuV4Q/hjqPSf66ElIl5e+g03Dxuv
 zWkw8se2RguzuDv5yXkC0ErWU1lr5ANJADZxKcIQ5k6rmJzwp9EBiSOWJQUJNLmZUoWXe63AGMj
 WuzJHnsNp9x2zoOp5FRxkaWd2D2dFpsYDPi8TbDTuIQ9tS5GxWnS42d9NJAAEWUMEhhA9cz8kjn
 fUn620J5O+eJ3w18tx7nuhR8oQwQg==
X-Received: by 2002:a05:6a21:6014:b0:3c3:8d4c:6679 with SMTP id
 adf61e73a8af0-3cc2baf91c1mr7520365637.20.1786471183519; 
 Tue, 11 Aug 2026 10:59:43 -0700 (PDT)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1412458a390sm1406229c88.14.2026.08.11.10.59.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 10:59:43 -0700 (PDT)
Date: Tue, 11 Aug 2026 10:59:39 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anurag Mandal <anurag.mandal@intel.com>
Cc: dev@dpdk.org, ciara.loftus@intel.com, mtahhan@redhat.com
Subject: Re: [PATCH v2] net/af_xdp: fix default device plugin path
Message-ID: <20260811105939.70335b3a@phoenix.local>
In-Reply-To: <20260811082757.1059350-1-anurag.mandal@intel.com>
References: <20260810101158.1011356-1-anurag.mandal@intel.com>
 <20260811082757.1059350-1-anurag.mandal@intel.com>
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

On Tue, 11 Aug 2026 08:27:57 +0000
Anurag Mandal <anurag.mandal@intel.com> wrote:

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

Looks good but needs a release note.
