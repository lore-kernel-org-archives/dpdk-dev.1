Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A681CC982FA
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 15:55:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B77842DD4;
	Mon, 21 Sep 2026 17:54:54 +0200 (CEST)
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by mails.dpdk.org (Postfix) with ESMTP id 3D91A42D91
 for <dev@dpdk.org>; Mon, 21 Sep 2026 17:54:53 +0200 (CEST)
Received: by mail-pj2-f12.google.com with SMTP id
 98e67ed59e1d1-396ccb65437so2432266a91.3
 for <dev@dpdk.org>; Mon, 21 Sep 2026 08:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790006092;
 x=1790610892; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=CgtFIlpdW8es0utWghAX8VSaxtXo1AZwF38QcXhvIzY=;
 b=jv0OV1Vu2t00RgoGbQKxMAiGjYACLU+jxAT/tYCYeFGdg5XKVtGo25RdSU5q63EWn5
 UN82N9pu4olVmSlC4h7i1cNW/Ed1eoFtyrJVNgzQmAVonzKc9pJxblgz16AbYbZbKdkk
 390YyZFKO59l9u2CnBiczbVBw/YkrAp80L/m79Z8bPtKStesFr0CfBuljthRWaaMaqBR
 O6oUsq+oRD6emUNuWt16cL2xNSRKV4r9/D2jZV3DE51HgKrFFwAcMFMXXeK5HhzybL7n
 7Qhpf13E9eVitzAkg+Cpb/d6isbPaWYxnp0ACteGVCfdIFaj6OIn1cAJZ8+H/MDcAX0X
 AwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790006092; x=1790610892;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CgtFIlpdW8es0utWghAX8VSaxtXo1AZwF38QcXhvIzY=;
 b=sSDrhwvsuyY9zLNCqOgNwYayInWrlhfoR4ribdiS+2QRIIT/hQ9ZZwZjP9l3GhbWti
 ExvmDaFJXokml79gwfQffqXeeIy4LQqglwI3UVa7w2rjwCTtt5dNxX3PDnGdT8pcHfUV
 vjw5tuoJjWwY2bSSxYKZt+hVpbHrq/B6eYQwbPS4JSopEHZIK3WVVcavGhLzkTcSM4BD
 9eF18olyy4o4rF54W7Ez9FAdhmaRdnrMIc5DPOIFdTmlpmUWLSxhebvYLkU4Q5XNRTIK
 grKpthVHrTxYc78gi1ufRKJVMVQpgZEKYMMr26GSBztdlsqGQJOVKFMawEr+QTsauWuE
 HvZA==
X-Gm-Message-State: AFuF++mN0HVBmExYBZOQ0q4udKZZL3jarq1oj4Cwx5NoXcrlJE+xylXN
 OT+g98VEmYz0Uh1DV8TbRdamWvilxOh4mN9Fg2+V9jddBLiY7R3ERrSZbKNQbCXQrCgZHjiyoUu
 cvUrR
X-Gm-Gg: AYBFou2VtjjDQ52B7TZeOw/dfhaPz9CX7dXDjzCZ2JrJ8nKGNALuzAVpH8G6aNMECQi
 PAo3bJy6kvkkg6xRuJRdLsAeB5fc4TMMS0QUAbgrhfzbsGJXoDOTkqDsluu1xcobSQQcz2nj8lT
 T3WCqx4p8nHnDo6XKxSWZB3Xgt4PK8CVfz24TNWsl9cxW23ywuewwaKcEjmhV7YvLRr19z5zd6g
 pfZ0DToMSX5Dwedzq/ki/vIgOlxyaIG2Nm7EuBSZt6gKjMlD5pfCv2gtIRJUjdzC1V8+AHIPmDe
 B+7cLFp3CYZJ6wfORKrzKh9QVgzvfcs0MRtFtFpiRTsr/cOtW4/HUj9OUkM93z9uSqzC96BxlSp
 RYwMOwuAA3s02mdVVvw79NURS+kMUPW4w9VNYlkNSwC6sVWH0RMjxl97BZNh/fflgrLG+wfoaJv
 RbFUk0dbtUHL63lb7Lb8gkNkrKUz3lK0nrOORmvuBmWGqT5F6NXeX6u8jmGTiw+7AMjctWsBtUz
 HppSzIfuH187/z+XzQnrykNZMba4DBI4UHXZAVO
X-Received: by 2002:a17:90b:2681:b0:39e:6c6a:4b75 with SMTP id
 98e67ed59e1d1-39e6c6a54cbmr10815654a91.63.1790006092292; 
 Mon, 21 Sep 2026 08:54:52 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a063c1994esm735465a91.17.2026.09.21.08.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 08:54:51 -0700 (PDT)
Date: Mon, 21 Sep 2026 08:52:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
Cc: dev@dpdk.org, kishore.padmanabha@broadcom.com, Keegan Freyhof
 <keegan.freyhof@broadcom.com>
Subject: Re: [PATCH v2] net/bnxt: add support for queue size of 16384
Message-ID: <20260921085250.46018e60@phoenix.local>
In-Reply-To: <20260921025903.1034720-1-Mohammad-Shuab.Siddique@broadcom.com>
References: <20260918032825.763449-1-Mohammad-Shuab.Siddique@broadcom.com>
 <20260921025903.1034720-1-Mohammad-Shuab.Siddique@broadcom.com>
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

On Sun, 20 Sep 2026 20:59:03 -0600
Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com> wrote:

> From: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
> 
> The driver only supported queue sizes up to 4096 for Tx and 8192 for
> Rx. Raise both to 16384. The completion ring for a Rx ring is sized
> at 2x the Rx ring size, further multiplied by 4 when the aggregation
> ring is in use (8x total), so at 16384 it can reach 131072, above
> uint16_t range - widen the ring index/counter variables touched by
> that path to uint32_t.
> 
> Signed-off-by: Keegan Freyhof <keegan.freyhof@broadcom.com>
> Signed-off-by: Mohammad Shuab Siddique <mohammad-shuab.siddique@broadcom.com>
> ---
[PATCH v2] net/bnxt: add support for queue size of 16384

Warning: the change of BNXT_MAX_MTU and BNXT_NUM_VLANS to UL is
unrelated to queue size and is not described. It changes the type of
BNXT_MAX_PKT_LEN to unsigned long. Drop it, or split it out with a
reason.

Warning: MAX_CP_DESC_CNT is bumped to 32K and gains a comment saying
it is unused and the real worst case is 131072. If it is unused,
delete it.
