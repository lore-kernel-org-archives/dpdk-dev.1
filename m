Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C59BF44872
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 14:36:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7DF8402DB;
	Fri, 10 Apr 2026 16:36:22 +0200 (CEST)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54]) by mails.dpdk.org (Postfix) with ESMTP id 23C314026C
 for <dev@dpdk.org>; Fri, 10 Apr 2026 16:36:21 +0200 (CEST)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-b980b35534eso296472166b.1
 for <dev@dpdk.org>; Fri, 10 Apr 2026 07:36:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775831781; cv=none;
 d=google.com; s=arc-20240605;
 b=SOfsAVQU5Wb6+mLywE2EkLLBwXVuuOuLcoJkA+eHXRIVUUtNqL/ZbwdEIWvrchnb1g
 g48rW5i8GUZAlPnqCxNYqQD8IUsE+As2k1kSIjriFIeX/Pp9BqvqfIG/xqmaXIYZlTgt
 VCs6N3gLK9i4XyxkypfRYCLhagepIEah2fBDIBeQ91g3lS0iNnla81ZvXQOEmJk3YTgW
 HhBIyunVmjasZU3bQaG+jLIA6G8W7SDtM2chnimcF9sb+9evMq1aZfrqKtCWpYI9zVZe
 JpN2jz4LqRouXYCeBQQNgelItP91IasOjRnkPhZRj0wVMIW8EUuZhSwN62RB/9lVtD8S
 eGlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=QuqyNNpitbnXJ0OxHQY5lDoEkYfRVFq17ZnkEjBcu1Y=;
 fh=ERBcxObE6Mh2AO3Paa6ChETnfriW6otAa+fM7Ol38e0=;
 b=jlfHh9rxRjlhyhldREP+vtuvlTzHuJvAv2TzHp2E5WHR0+aT8kdKKiUUlt8RjF67nW
 S7Mt+epVcbmngz2fb4edyvwajeaCoJAGFKodH/YwOfTe8cmZZbJ3SSogFebmcm6RwlX2
 gWJrEJEZzQoN7BR5VKamrCT9IK637kCtjgcw+ADatDoIBxp/QauAiwVocc1Obav7HMM1
 1iut9tuWDFK0QeQ7mpFeaba80mHHuOsGDIiMjJUoY6Re20RLa2M5CZPjLgtZNAoZqNVe
 DotCswN1q4jns/maMpWlrtV6/fWlM29fNK1eZf6aQvao9QPfFJoEMNUKznQu9WRUJ8O7
 ZD/A==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1775831781; x=1776436581; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=QuqyNNpitbnXJ0OxHQY5lDoEkYfRVFq17ZnkEjBcu1Y=;
 b=Ugt+SeoREkHSx7g54SU4utcj0Jeq7eDJRWiisaVQixcZff3bVOPSWPUqZBb0VIRAn/
 MQNBHzCas4M48gHyAn1dxqj7JVwWwjLxDwlicrKvkB2l0nkTtw80zl/lui0AWkWymS1g
 EB9EwLqBUbanYUvzWymAGvqSTUilmDBIk4D7U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775831781; x=1776436581;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QuqyNNpitbnXJ0OxHQY5lDoEkYfRVFq17ZnkEjBcu1Y=;
 b=tKOzJxSoi5rZNNizDWLJbkGqJc0EXAsyiyrLclizKcGCzDXx8SVToX7q0UYcZhOy2B
 mt3ZMbF/BVIWybWnTIBQ/QxW3p74f4fpS+/IRkzdRmYfmFtvjaxTkYHe1PL0gA1KtOOr
 4TGSE//L6Cih3NCUMXfZs3eJxQMoE0lEZV1TsRMxwuXOh00xORBh3xX2+kIVESTZ18fO
 eJEQbkkJp6BTLEQfDrPijF24lC7QZHZP8NfJF/OYhv3nrqE+9xPVq3J4dzsgmml4tqfI
 vdSGgH1BWd5/K67cLuP4A4k3+WNDmvCm7uGtwkgF6PxEN4IzKZ/uJTBEu3KDcX/+55Hf
 743w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU765sBJVx2dcWffe4M0bD/oX/gXXpp2FbngeKMkTDLkhy44BwxLRB5KT0H4ZIPb/cUkUI=@dpdk.org
X-Gm-Message-State: AOJu0YzOKr9Hhaj/4F59pq9kIlpo5OfZt6Yjz8DbBUS8TexD1LDsiwDU
 YHhIhoCC+El4zx+OF7QiFhofZjMT2raKDcb+AWGs9aTaOXLVNyKq3kVVzKBxzLvihNAsXbDjUKA
 6el9QHsMc9AKeMoh9vIJHC59CCWjm9bhxbDMPAbSn8A==
X-Gm-Gg: AeBDiesMOiJ/lQfJ5I9jQ4f/7Ky7O5wz0AWMJzxyFLrQlpkeqnE2bqeZD6RVm06hlSq
 Il74F/3S91Zg85NvDDLTa+YUjSHlorENcefVE78e+/I3isXx9qJVHDThfraRbs9KGESrBy/IPqM
 IRvbo2t9DjqVNgxWNRNTXLJcWzlaHrhejg1cJUGHj+6RJRIwKbCDKf4Mil2w2lAyZisHs8Eb/Hb
 k7tjZT4r7nnsMwFdfiCkPyhAjyrvrTDjRSvg/Ngf+nL5e73Mkq8bA3cJsJWxsfGmWfZg6HM+qvR
 LcnbIpvaF2TVPHHLbqQtesJc94BzDahydcBRub8c
X-Received: by 2002:a17:907:1c2a:b0:b9b:132c:a590 with SMTP id
 a640c23a62f3a-b9d7684d82bmr178591366b.4.1775831779769; Fri, 10 Apr 2026
 07:36:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260310184416.216482-1-abailey@iol.unh.edu>
 <CABD7UXORAbHZccnvYh9=BZnZZ56n5O3N_kjywFpenyKHJ04yHA@mail.gmail.com>
In-Reply-To: <CABD7UXORAbHZccnvYh9=BZnZZ56n5O3N_kjywFpenyKHJ04yHA@mail.gmail.com>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Fri, 10 Apr 2026 10:36:08 -0400
X-Gm-Features: AQROBzDcdoliD5T6YOzFt4mjxsTzZQqz2IDhWeaIu0pm_vY-27nYBQY1jL-MP5c
Message-ID: <CABJ3N2WdBAsVJNA=yqMVRifU=mVwJZAgZLtFoTD4BPi70xFG7Q@mail.gmail.com>
Subject: Re: [PATCH v1] dts: add default values for queue info
To: Dean Marx <dmarx@iol.unh.edu>
Cc: probb@iol.unh.edu, dev@dpdk.org, luca.vizzarro@arm.com
Content-Type: multipart/alternative; boundary="0000000000006a15ff064f1c0ec4"
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

--0000000000006a15ff064f1c0ec4
Content-Type: text/plain; charset="UTF-8"

This is an update on the status of this patch.

This patch is pending review to be merged.

--0000000000006a15ff064f1c0ec4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">This is an update=C2=A0on the status of this patch.<br><br=
>This patch is pending review to be merged.</div>

--0000000000006a15ff064f1c0ec4--
