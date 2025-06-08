Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82313C5B552
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Jun 2025 15:47:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EE25402A9;
	Sun,  8 Jun 2025 17:47:14 +0200 (CEST)
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com
 [209.85.219.50]) by mails.dpdk.org (Postfix) with ESMTP id D35B640269
 for <dev@dpdk.org>; Sun,  8 Jun 2025 17:47:12 +0200 (CEST)
Received: by mail-qv1-f50.google.com with SMTP id
 6a1803df08f44-6faf66905adso22282286d6.2
 for <dev@dpdk.org>; Sun, 08 Jun 2025 08:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1749397632;
 x=1750002432; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TuiyZMIW3CySTx1w5cXVaHANeNJrFASb0p+CAIOQvLE=;
 b=Zx+WHy0c5MmQNhvu+op2sYOA7jsUMW788AZPAjQ98AEAsEU6EPkZ+qmvmgzO2fb3fS
 CL3F+7pzqkXPsKnN+TEWH24vyWqMscnl/Cghq5/AR77B/xivVNFPGe2o22pX30Q1f17t
 0fQJjtYcoUEK2QfkW7NOWACaMKTRLIOMcshAD5ai6+CDBG1amkEN9oR7reBVPgVcU7oK
 utKnvg4Ghw0AeKg2cEf+yOrbs9hwOWvPmBnIJ7Fe8ziwkQw5qMuJgwZwjNo92gIiJLt6
 aI4qWlnt5SssZz64kcad/lgwldEcKFu1xkZ58vTJFcc3llPJAAeNjITZCIRRlDQaLfz9
 NBxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749397632; x=1750002432;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TuiyZMIW3CySTx1w5cXVaHANeNJrFASb0p+CAIOQvLE=;
 b=a1oZUzgElJruYnPaevEbxUDUALr6+nURxLa/DPeYCFkpm3zq3m+3eCyhiRppGOI19u
 9M2WKiA/umuscbTX96o7HrHBd0DgwOOI4jYY9wjV9bxJz71BY7cSkALxhPf3cwzqoxki
 vla/gqgJXQl1qH4xtYs0hf+EyaKd7vKBX5v0ywy22F+gb9TuMLWY37dTNRN/atyeELCE
 PWf4DqUlYjsA+Vj16TG6fS5DfCZDtsTX50kfqvYG9B4rLHNXlhrykfftgExLUCVfyBAD
 YmqYvVJVmL/a3zsJKiUGLDsyTGZ0O6aAadfc7DCvYfFbGxi125M+aazz597grdrveBQu
 5FQg==
X-Gm-Message-State: AOJu0YzKxf5nswhpZIFBJhbgaEpgTtrH1NFPgiFQmmW/xjciJYmYlElu
 5rJEEEwEMuu5mZuYD4ge8gDf1z321ui25FlieOFsnUpur+LZsivM1/yEW/9fO2HzhRk=
X-Gm-Gg: ASbGncv35iDvmJQ9IVQ03S9aBMv+4eTG8U73CV4f3xM6oY6WCuP5VZbILpvKK9cnogv
 IzmRtdKhNLDKXnxc8FHjcVntUk5dXz+NgCAGcebAxjWLhIZqfHlOdpl8WLCZOd5/+oTtIRVQUuV
 u1gVkHHwW+swnTbCM1kcKiTfh+gmfiXuZRTc0JAuDdGYBuXFVLleqNn0E3rn1sjLPnWngQTX8MX
 me1W5N2MgwLvMYnQnP6uXGQXxeGX245msllFTbhZGlvEqJRULNyPQFZvasbn8HsFj3WqG3pqHmY
 +jDeYDPyyxCy9iIeoNgNAj2DPqKRb/JZJvoHD5gm8kf77omRYW/QrPkNhSfTS3tRqHh9FRJ/zEq
 KsQJ+Q1BXe7vM7j0jCkbIlUY3SjipoYZJ9Fbvny0=
X-Google-Smtp-Source: AGHT+IENRidVOEefO+YQ9UdWX+ToCh1A1xWzsA7GXm3QedqNZ7W+CeLJALEZsuRYk7MhDQh3hPZ/uA==
X-Received: by 2002:a05:6214:508c:b0:6fa:bd17:31b with SMTP id
 6a1803df08f44-6fb08f987a3mr151060506d6.43.1749397631892; 
 Sun, 08 Jun 2025 08:47:11 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6fb09ac94afsm40050216d6.44.2025.06.08.08.47.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Jun 2025 08:47:11 -0700 (PDT)
Date: Sun, 8 Jun 2025 08:47:08 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: venkatesh bs <venki.bsv@gmail.com>
Cc: dev@dpdk.org
Subject: Re: Question regarding rte_hash_hash and
 rte_hash_add_key_with_hash_data
Message-ID: <20250608084708.71377b9f@hermes.local>
In-Reply-To: <CAM3UhOgt2UmtWhvobLyVzX=gmj46+RrSNGbfKH3fSQ-yhxTw3g@mail.gmail.com>
References: <CAM3UhOgt2UmtWhvobLyVzX=gmj46+RrSNGbfKH3fSQ-yhxTw3g@mail.gmail.com>
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

On Sun, 8 Jun 2025 00:36:02 +0530
venkatesh bs <venki.bsv@gmail.com> wrote:

> Hi @dpdk community,
> 
> In my application, I am using the dpdk hash table as below.
> 
> 1. calculate the hash value.
> 2. using this signature add the key and data into  a table.
> 3. lock is used in the 2nd call (add).
> 
> Below is the code sniffer for the same.
> ==================================================================
>      hash_sig_t sig = rte_hash_hash(hash_tablele, (void *) &new_key);
> 
>      pthread_mutex_lock(&lock);
>       int32_t ret = rte_hash_add_key_with_hash_data(hash_table,
>                           (void *)&new_key,
>                            sig,
>                            info);
> 
> if (ret < 0)
> {
>          pthread_mutex_unlock(lock);
>          return TOS_E_FAIL;
> }
> pthread_mutex_unlock(lock);
> 
> return OK..
> ==================================================================
> 
> My application is having a lot of threads and when run with heavy load , I
> am getting a lot of insertion failure, i felt the reason could be
> calculating and adding the has value in 2 api's as opposed to
> rte_hash_add() that is safe under a lock..
> 
> 
> Please let me know your thoughts.

Which architecture and DPDK version?
What flags did you use during hash creation?

As always with open source, the first thing to do is look at the source
and see what is really happening, rather than just relying on the documentation.

I assume you are using the default hash function which is CRC.

First what is the return value, which error?
It might just be key collisions. How big is the table and how many inserts?

Also, the current DPDK hash flags with better locking and RCU.
This would be faster than simple pthread mutex.

