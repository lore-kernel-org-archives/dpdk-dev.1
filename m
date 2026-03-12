Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C9E106ACEE
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 21:12:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B497402AC;
	Thu, 12 Mar 2026 22:12:50 +0100 (CET)
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com
 [74.125.224.44]) by mails.dpdk.org (Postfix) with ESMTP id 9C01040275
 for <dev@dpdk.org>; Thu, 12 Mar 2026 22:12:48 +0100 (CET)
Received: by mail-yx1-f44.google.com with SMTP id
 956f58d0204a3-64ad46a44easo1565839d50.0
 for <dev@dpdk.org>; Thu, 12 Mar 2026 14:12:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773349968; cv=none;
 d=google.com; s=arc-20240605;
 b=cMC4H8kpcQIzDk0TnLpHcaY4tzVvYojbBPBGNMvWgofl5pYHOrzmkpncJrfs0o0vf0
 cPlyGtVlqAOFJd5nSvdsI18C/lG70qlfpxsq326FbALTOExNKKjn1jY9VPND4phviaQN
 xJTVN22Mxb+BxI7C4s077tbLKwkIqjKIIck9DmjvWBzKYbwFzurJWqFb+9+ojomrDQA9
 pYrPmcDQMsV4c7fjdHbsR+T3lteq6mz9lXCko+SYXjZoqYXegl+ZhK/fyy5yDgYhTQG4
 KLHHECGT5jIBSGFXwjxA3QgUBO0VAAE6BWQatvJCF22Y8Bv8QXZ9XdG5mxUJHuC2Zvg4
 n1ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=zLUt35CkY5jRpolVszjjqIDyQcQmzy1dOovOB134ppU=;
 fh=M3dh3OKgXEsntcmNU9NOVq6fxFbWY4RAg+Wg9C+KSYE=;
 b=bTC7UtjT5KGj0tydAjIxKW428nuYGoatbjro5EXKpgIeZ9ysw7NPHF0QhDt6BL/AL7
 g2KG5EFEqp2F1EgY6ZlsThZHoEixBGo5cv+nhP+omQa7K0M0SICR1nqLuea7vquFP4g1
 zVT8ItARNxf9p0RbEW3zYEXCC9GPP/7nnYOY/FgbQw0nG7feJl6etJPUmLuGWEabT27w
 xNS+PrjFNlJlvKVul8JyZYxPfoR0b+TMR5YfOhE76SLklA37U0bXA85YQtzslAJb2XTj
 GnRoBwTWsE5hOzvBm0wxfHIlHX8LkNL4zgXt8/u9jtK6fAwiHUm0a7/zacRr2BqneZK7
 22+g==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1773349968; x=1773954768; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLUt35CkY5jRpolVszjjqIDyQcQmzy1dOovOB134ppU=;
 b=GTy8jMNZx57+a+jwdoEPbFJpVLVRCol+zwYWw62V6qSHw12vNwW4kNnorw5n8m5oZo
 ZFE9cSrsL0H9O98KuPCV+wy7ytQdn8qrEH5dtMvOTa3LQmrATpEDCWNh9sS3SxDpgX8V
 t4abtyKceahunkcpscQQX3FSCY2kLemXwITdM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773349968; x=1773954768;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zLUt35CkY5jRpolVszjjqIDyQcQmzy1dOovOB134ppU=;
 b=i40GCGCuWakieaf8ChaQbf6vduUUDKmDgX1lE+NlceWo/cfJixbMSQCxRJ+9erDd7r
 FsAvTPcaYZQIZ6zoo1LR+soRVlOCCC9ehcDkm9QmO1bcTy2Et/VrmWgA03ckc4Ww+Vcm
 Iwht8z9MepoLQkDUOwtjX0/9q1MtmiGU84mbj0ZwJrfC05GRen9lC5KaKq7dmMp89a4F
 YIpqUVdd3m/GJXIdfOOmRysmvaYpqP7KOs5kj8DxbMdGzg0HsyZ67r4c59KPl3+ARO4H
 rBNF3QRipJGCq3fCRTe+b+SeFQXNTLr60KicTH0SN5gd8bjH2cbesC3KvwahyBMIKlaf
 XASA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyAHeGLzisZCX634D0zg6AMSHlzNwTpmZhVzz7V/EOVf34pUqvXFBJYLE9LNzL8qdJ8vE=@dpdk.org
X-Gm-Message-State: AOJu0Ywy5vqSGfqI/NUnZvtoDc6IP8nQrTZkf+GH3BDl7ZKoATWki6xu
 TU8jf44DLCdTwYtPAciE4m66ic+kyKQOuwXXHlP3H29uSZFiT5grxchpdD3w3p+GhxKuEGgq/Bq
 oTYPgl0rRQcM6IxcaLi50i/olOdX9aPZOTn73ER+HTw==
X-Gm-Gg: ATEYQzzPBO9bWDfIpb+L74xYKUbBPFuaNsj+Kv3MYF1a5BJprPmbZLqh5bkzOYE/l3n
 S1vqxkmLrkbezT+PVVnSN9+2/OBbHa2RDtZrMaY5EYccHclHKnXUd1kkyLn98/Ub1Oy+T34DQeS
 Ar4g9WwMB7+7Ku9+JvCtd0fGFsb8gVodKqOUAzs+yl57Sv/WAs4E2fJK7ejUsba8HzqUHV+z6YY
 478tBvPmeruRaOYAXIHBQoyf9xiZPpc6n9tKWjhWnYe1M+fF3qG5xMNKXTzstDGEK+mcIBpijI+
 txs5webfnIr6B837GPPi/B8fqR/o9pEXzjgK3ZR/mw==
X-Received: by 2002:a53:b44b:0:b0:64c:ec4d:4a55 with SMTP id
 956f58d0204a3-64e6308da8bmr830524d50.74.1773349967819; Thu, 12 Mar 2026
 14:12:47 -0700 (PDT)
MIME-Version: 1.0
References: <20260310184416.216482-1-abailey@iol.unh.edu>
In-Reply-To: <20260310184416.216482-1-abailey@iol.unh.edu>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Thu, 12 Mar 2026 17:12:36 -0400
X-Gm-Features: AaiRm51KLfReG4Ilnvxw2XSZMUq1NWtbCw4SqR6nVOmTj3kEE2qpNQ3ZlDqIlxo
Message-ID: <CABD7UXORAbHZccnvYh9=BZnZZ56n5O3N_kjywFpenyKHJ04yHA@mail.gmail.com>
Subject: Re: [PATCH v1] dts: add default values for queue info
To: Andrew Bailey <abailey@iol.unh.edu>
Cc: probb@iol.unh.edu, dev@dpdk.org, luca.vizzarro@arm.com
Content-Type: text/plain; charset="UTF-8"
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

On Tue, Mar 10, 2026 at 2:44=E2=80=AFPM Andrew Bailey <abailey@iol.unh.edu>=
 wrote:
>
> Currently, an error is raised on some environments when running the
> queue start stop test suite due to fields failing to populate with no
> default. These fields are not accessed by the test suite and this commit
> handles this case gracefully by setting the default to None instead of
> crashing.
>
> Bugzilla ID: 1901
>
> Signed-off-by: Andrew Bailey <abailey@iol.unh.edu>

Tested-by: Dean Marx <dmarx@iol.unh.edu>
Reviewed-by: Dean Marx <dmarx@iol.unh.edu>
