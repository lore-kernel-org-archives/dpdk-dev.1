Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DAC1C9830E
	for <dpdk-dev@archiver.kernel.org>; Thu, 24 Sep 2026 15:38:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 802D04027B;
	Thu, 24 Sep 2026 17:38:50 +0200 (CEST)
Received: from mail-pj2-f34.google.com (mail-pj2-f34.google.com
 [74.125.227.162])
 by mails.dpdk.org (Postfix) with ESMTP id DA2AF40144
 for <dev@dpdk.org>; Thu, 24 Sep 2026 17:38:48 +0200 (CEST)
Received: by mail-pj2-f34.google.com with SMTP id
 d9443c01a7336-2d747eb79f7so10929465ad.1
 for <dev@dpdk.org>; Thu, 24 Sep 2026 08:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790264328;
 x=1790869128; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=0sYul/WzsYLDdAG90gvVW+wEZOwUAIf5rGedtzt5lZI=;
 b=AsWMeB45oF4iZRSoY/s59ggxD8tHU166k+fQgkYJazO8OZ/nRRUXFPSG5FIyj/FBuE
 qygXXERCIk+4Os0GZmdIa0BbtDQ/Sl+cvrAD3cGzvvVf/r1QL7zjfa+RbCkdaUeEa6mi
 TTZHsZH5Cq1pEGcUi1Eag5juSJp4jL4KWTwI5ImV1SfHrMaulmbACxHBRHutu9GtXMhH
 hOcR3+oPjznd0vvTNCTVejBLcDhQDkbxGIJUJZG+Y4Xwg95cnkeZdKMakpXUojpjiQ1u
 PAOJj9FuUAXT5WrwXWoOwv8KEJ96uniMhOrjXu3rqkwfkY+GtiGxKWR3lqkH/lVa/m9r
 +/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790264328; x=1790869128;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0sYul/WzsYLDdAG90gvVW+wEZOwUAIf5rGedtzt5lZI=;
 b=zVrA2VAzKkDkqd7U9olZyuOOIapNC3OslZbA6lxmijZVI9B2muuOYpF1ad3pb9QQCQ
 fuCeFuDNYdEhNpHoa3uWihIQeNb70XOHtSkDYZvANYIQr41BdSoFGMKi+zok+87jeNdn
 yyQEzki8o0nn0pI03R3IloJT/dDVHVRbLhcBt2yNhy0JMEdoO/Vuuq5HRQzXqrzaAm/0
 D88AGVYbRnyfq8czntDfo0h81McOpARnh3RHRRp4v86ci/sJdan/21LRv2nCoXww8M8j
 +f1xzgsIq2OKp+XvsNKSPhJQx0FfIPQJ9y6wD6t+/sD/lFzqUkzDiyxcO74XrTwx2VeN
 313A==
X-Forwarded-Encrypted: i=1;
 AKwUvBy42P8hOQ3j1DIU1ZhB4xyhxIiPAJ9dvNIAKBMYSKwNUuohKmH7caMnPNirugIqFQ9Qcck=@dpdk.org
X-Gm-Message-State: AFuF++m/pgaeBbMSqDovVTCtOZY8EdE6aWe+lLRjZCnTZUOfNfLWPtly
 c3nIeXDwJU8MuaAfQ4wFg6xP3H2R/Pl407OnYxMgokM9VU1KENpMwiRcgcVsM6KyMZQ=
X-Gm-Gg: AYBFou0JT9icolgRc/95C4IAIQZR8HHUqVAWMRtc9fxb6ZzSd7Jjh6mmEF3TlL5Vfxz
 6wbQdG2n4hy+6kl1MLNZwRE6EWz6fcXIqElEuHsbltYbJIZenN5BTSyIwJU1l1tlF4lEdXA2uVl
 OEwxCyAUis0l5HDWaKlfjdSH35qwTGf2fz2JQjNDk9Lzfm93pBg1DMN9nMnMSkL34ltzQrR09qZ
 MTWO5pnvNSbNDIdkj6DTfqTl35k/lpWhfHnvWsRG54JNvdSsCcufzfFrNPq6J4AHjkDzMiVt2m1
 +Y/qHV87Db+Lw1a4+jZyfMTR9PCdOxSUk6rglFXz8ZNxgPTPrWu4L5dZ2gW9VFVB64WCLncOsa/
 6bVQk4uXEfMan3wEYolWAmCI2ezeENWKX3ZwGZ6XeaI4ZLiaHab7xYt4aJA/HILyzInCtMhbQTm
 +7Go3Ds9Q/HcCdi//pCZBvjn3lTKjkHxOzJb75T4t8gN588GpFsJomDpUcLwPtcx5VWXucWCq4o
 t8SjOpqDQWrxXg7P5/EDKhuoletaml1fyWT8XmniA==
X-Received: by 2002:a17:903:b4f:b0:2dd:c0ff:e731 with SMTP id
 d9443c01a7336-2df7e006eb3mr25619755ad.67.1790264327825; 
 Thu, 24 Sep 2026 08:38:47 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2df6a5a7b53sm29534565ad.21.2026.09.24.08.38.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 08:38:47 -0700 (PDT)
Date: Thu, 24 Sep 2026 08:38:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Eugenio =?UTF-8?B?UMOpcmV6?= <eperezma@redhat.com>
Cc: Maxime Coquelin <maxime.coquelin@redhat.com>, dev@dpdk.org,
 chenbox@nvidia.com, Yongji Xie <xieyongji@bytedance.com>, mst@redhat.com,
 jasowangio@gmail.com, david.marchand@redhat.com
Subject: Re: [PATCH 1/9] uapi: import VDUSE and VFIO header from v7.3-rc3
 kernel
Message-ID: <20260924083845.4d854df3@phoenix.local>
In-Reply-To: <20260924101504.810315-2-eperezma@redhat.com>
References: <20260924101504.810315-1-eperezma@redhat.com>
 <20260924101504.810315-2-eperezma@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Thu, 24 Sep 2026 12:14:56 +0200
Eugenio P=C3=A9rez <eperezma@redhat.com> wrote:

> This header will be used by the Vhost library.
>=20
> Signed-off-by: Eugenio P=C3=A9rez <eperezma@redhat.com>
> ---

Best to avoid using headers from pre-release kernel versions.
