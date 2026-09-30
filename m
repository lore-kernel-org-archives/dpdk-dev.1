Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAF9CA5FC7
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 15:21:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3FA8E402C3;
	Wed, 30 Sep 2026 17:21:52 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 84C1F40278
 for <dev@dpdk.org>; Wed, 30 Sep 2026 17:21:50 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2d747f01363so33074145ad.2
 for <dev@dpdk.org>; Wed, 30 Sep 2026 08:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790781709;
 x=1791386509; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lZxKz4d2tdmsWl5qp5cv2Gekl93lFKL3ko83oa4UB6c=;
 b=JAnvTlHIBXGwb2FnFMc3QefUZcVSOK7vX571EdrWFFQsN3mcm2xyHd6l7nPgxv87O6
 2jhauf9dHabXyrhg1P6iRKkwmmuygeSsuN3uv7P+QT9Wu5faTK/W7Gsn2Lzsjb0RQJOI
 OHNZvs/WwALQphWgZHptPW0kRULxIL0TGqklDLd7QB9el3yWrvgyFZFZgdBVeh6BCkTb
 7KNHJ+zlcc8Ai0Va1ujvbgpwB33UAnDl7QKr4hGodIc63HtVjofkEdU6ZZvpTL8MbDmH
 r+VjTJ9Y26R89isk9CvlqJryCl1feg/rpyYkcwU8xBPrkzZWxvnnson2kYPuA1sfZ1EZ
 26bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790781709; x=1791386509;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lZxKz4d2tdmsWl5qp5cv2Gekl93lFKL3ko83oa4UB6c=;
 b=ThojF+isvuDfmVVGYrrFKF1mFuoMMMDoEliEzdcxSQFmaaD9Bo7SgRWnAB7PkksikI
 /WXHf40JlXn/PJ+ReRRGP63+9GMURULftDku0HFpZSX4VJxe4ADJl/buj2KsJmlXbHON
 XRXHph4Wbe1T1mLO30LY/FJx7sMZ98AYDMadc766rWbSkgGzV1kG9ZAKEMgGWzU8AN5t
 +pUvf6txtJQ4W/UQmyMHbaYI8/1Xjn8AB8OhALpAB79u5cJFA7CvxL3drbSOvYQ2b3tj
 Y6Gc4mZLj7x9T+rawyNWfEtx+UwRPs2pQZyReW1xFvO5u1RDni9BEmSpJcq8I3djf5kK
 PhRg==
X-Gm-Message-State: AFq9FYISUe5Jalvkjv/Xe6PQUJ6CkJGN7tfjZggUZpMxmR6Nhp6uFb5D
 ltdglfeKs3R1cub5rorrcKrigby4Eo4u2tvXY/P0IGT99dPtds4L8iIkH7FQ6k1fxMk=
X-Gm-Gg: AYBFou3h2KI54AAS7xCRpCrdmViOsDiVUNe8LqnbP/+oJFWACktTwqsnVDvCJyroW67
 /PHw7UmkwtM4WCcZqUc4UtdaINhLKcEffTpro3BDkoUDQwvQJVzHvA/Z90rkEI3ONCuQ/UO4ZfZ
 cek4qUe+9vWgiuAa8RGiNBMrVDhjRut8ayyGG6fegIO8K4koUe00DRaQbQwhFHaM8yOPkejaLtR
 cmqfDXCtQA3GOaLYSOczK3un06tUO+wOhLbM6oMjNWlmYHPgVZXPN4uJI2pNzNyWb9P69pOC/z7
 cm+Tv+yddtmoLNf6ukM8FD1T+76Xwc55NFjet3qdDrBKAymVWFfPJc0XgPRYQpNJFzrtfDqVzw5
 +jWDJ7VhUF5nig6RMQ/QjyRSFQj5/NnEWGPIuPlmSdHdzJEHPwn+G7K4SYWke/tyAyB4g+l9Hll
 xR/6eTtMJrPuJitjvRby3/MTLZylv2hnhjoIOiC2s/QO+2MLz3VIp+vibAzxe9r3I4DOJoAvWzs
 c7MwyXbBLP3YndU6pN/BhwW+6t86JZuS6BIbcHnsw==
X-Received: by 2002:a17:903:3503:b0:2d9:51db:7eaa with SMTP id
 d9443c01a7336-2e2e4989214mr12563995ad.20.1790781709264; 
 Wed, 30 Sep 2026 08:21:49 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e2e5c27fbesm9440585ad.73.2026.09.30.08.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:21:48 -0700 (PDT)
Date: Wed, 30 Sep 2026 08:21:46 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: fengchengwen <fengchengwen@huawei.com>
Cc: <dev@dpdk.org>
Subject: Re: [PATCH v2 00/61] kvargs: add numeric conversion helpers
Message-ID: <20260930082146.570e0f0c@phoenix.local>
In-Reply-To: <94bad4cd-30e7-4cad-87da-f9957f620088@huawei.com>
References: <20260914054912.755403-1-stephen@networkplumber.org>
 <20260929163800.1108305-1-stephen@networkplumber.org>
 <94bad4cd-30e7-4cad-87da-f9957f620088@huawei.com>
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

On Wed, 30 Sep 2026 09:14:22 +0800
fengchengwen <fengchengwen@huawei.com> wrote:

> > 
> > Library (patches 1 to 3)
> > ------------------------
> > 
> >   rte_kvargs_to_uint/to_int/to_hex     convert with an explicit range
> > 
> >   rte_kvargs_handle_u8/u16/u32/u64     store into a typed variable
> >   rte_kvargs_handle_i8/i16/i32/i64
> >   rte_kvargs_handle_uint/int/long/ulong/size
> > 
> >   rte_kvargs_handle_bool               1/y/yes/on/true and negatives,
> >                                        bare key means true
> >   rte_kvargs_handle_socket_id          -1 (SOCKET_ID_ANY) through
> >                                        RTE_MAX_NUMA_NODES - 1
> >   rte_kvargs_handle_hex32/hex64        bare hex mask, 0x optional  
> 
> The argparse also provide such convert functions
> int rte_argparse_parse_type(const char *str, enum rte_argparse_value_type val_type, void *val);
> 
> Can these be merged into one?


No because argparse takes different function signature than kvargs. The point of these
helpers was to be drop in replacement in drivers. The two overlap, but kvargs covers
a few more cases.

