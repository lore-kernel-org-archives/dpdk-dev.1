Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F09E7C6E1
	for <dpdk-dev@archiver.kernel.org>; Sat, 31 Jan 2026 19:54:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A97D6402AF;
	Sat, 31 Jan 2026 20:53:59 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 68F9540274
 for <dev@dpdk.org>; Sat, 31 Jan 2026 20:53:58 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-47ff94b46afso28654755e9.1
 for <dev@dpdk.org>; Sat, 31 Jan 2026 11:53:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769889238;
 x=1770494038; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=03LCMqtnNvWe4zHpU/SftynHbnSZemeDaGIKfcGRnxs=;
 b=SnKybWaV2rGSJ155/MgZoAbeMDWqAccTevpZdlrO4RCVErtVlpVtO2xEonNFgtKIDu
 lZOtQKm4VSLVywZDyr7Z/jBzLWy5OhUhtIKRN//qtLCBo3JGmj/xJ1wjG011/C+94b9q
 //UHWIIQ5eJQaqOsAmwgQYujcEa+FQgR9p4t22NSaVGWtZcfaY/A6DuMKhEaRt6KK7tg
 2sqS0BmZL7rKNqfPNj00JRUug08d+yScZNE2WA1qipwEfAF3bGxXZIZkb3Q+cCtLJX5j
 FIxBkAO85sT8NZfXfKeDkncKIblUrOCDf0xtENfGj/+LQu6mYphHJKfXaSGzUxn1gepU
 kDog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769889238; x=1770494038;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=03LCMqtnNvWe4zHpU/SftynHbnSZemeDaGIKfcGRnxs=;
 b=hxniPMFVpORXhkJd/YSggkVDS5sS7rkzAYcL718MBDZCxH/rjJG/ua77L6Nbwk+5Kw
 F4cMPsAv/n25zBKtXXcufn8NGxDuJ5iTaL+Na5L2jGR5a2MkFYFV9xszaE8Ff8auXjO1
 ma+xxo+7rPmYo2PRDUq3PVCncA6vIY/d2G19kN1LyD9elgErwV30nLhM8ZS2zfIiySP7
 D2lJJQ6lG46rX6G4QmCaX3ISn1SMrk9CJ18jcPrY34edSIajiQh3MDALUV2BTP2MTBus
 gSVawTUTlviMTRDD+JL6tZHH/QhwwNFW4K59uKvTdfjgZNgDRzchG46/0aawmPnHyyvK
 DpBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXzzao9NXoY1Rc5sRVkLn1D7Jj3RnJpWrh8CfJM66Cy1ElmbINzWVPNbOLT73vQXISdS0c=@dpdk.org
X-Gm-Message-State: AOJu0Yw904Rs4t5RslNbhVBWhRGP06D4MpPmgxKm9JR1PK5S6EV9T7p8
 BbSFTHftHdwBGQ4Q6bDbO3QnYLkdi7zf9yhH0AQ/44sRPEDrqf99MGbZPLrS6qwlYx8=
X-Gm-Gg: AZuq6aKH6ZxBwj7j2ApaMOk77scFotTpxn5Q23bS1ziOuqUwvk1Vlr7mqfzeNG01UbH
 SOzBD1P7CCLCkqGyvCsAIhD1SGR13AD7Kxxv364oY0w/7dgAw3mEqQcxXz2C/iAjT1dU2z+JOBS
 8LDZ1DwskmqXzk+VSG0X4k1Vrg1KoWac0ohkbw7VLeHb49vtqBBrTySOEIOuZKKB4M+CNX/yTc8
 bFk2v1BuxBbO6G8SBIRnYQhsl6LVxpzJkfyxA2nO3bhj+/46tygKQUZNYkTikC/6c2ZLbyHGVLT
 2/g6rL/TdI1pmh035BE/4TO5y/cryZ/7szxWK6reRt54RSkkxUdUnLUNiqCDBT8AfwPveN+s3tF
 r+j7ocHTZQ3XT8WVm69CWCD6TjlWepXtoeCzutG7nG79fnyl/qRkmTF86764IuCC5gHI9S65lYG
 1Y3wEkkHOdXRLyV9F+aF9NHoYjzjiBmOv7H9937POiZFf6IQsx71LE
X-Received: by 2002:a05:600c:47d5:b0:480:63c1:3ac7 with SMTP id
 5b1f17b1804b1-48082874614mr88898725e9.2.1769889237947; 
 Sat, 31 Jan 2026 11:53:57 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee040sm31554833f8f.11.2026.01.31.11.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Jan 2026 11:53:57 -0800 (PST)
Date: Sat, 31 Jan 2026 11:53:52 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Rma Ma <rma.ma@jaguarmicro.com>, dpdk-dev <dev@dpdk.org>, Chenbo Xia
 <chenbo.xia@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>
Subject: Re: =?UTF-8?B?5Zue5aSNOiDlm57lpI06?= [PATCH v3] vhost: add notify
 reply ops to fix message deadlock
Message-ID: <20260131115352.1891034b@phoenix.local>
In-Reply-To: <f20b680b-e912-1c1d-b8d7-4f99ca9e97f1@redhat.com>
References: <20230704023228.24879-1-rma.ma@jaguarmicro.com>
 <20230704025157.26024-1-rma.ma@jaguarmicro.com>
 <PUZPR06MB47423251E6A4BBCA6B9FEDA39931A@PUZPR06MB4742.apcprd06.prod.outlook.com>
 <13dcdbde-df66-fc17-3eb5-d23bb6836a55@redhat.com>
 <SI2PR06MB47521141F4002DB03B31694E9936A@SI2PR06MB4752.apcprd06.prod.outlook.com>
 <f20b680b-e912-1c1d-b8d7-4f99ca9e97f1@redhat.com>
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

On Wed, 12 Jul 2023 10:06:05 +0200
Maxime Coquelin <maxime.coquelin@redhat.com> wrote:

> > 
> > Hi,
> > 
> > Our company's jmnd vdpa driver, which requires the 
> > rte_vhost_host_notifier_ctrl interface,
> > replicates the problem with the following scenario:
> > 
> > QEMU start vhost-user with modern net and blk, backend use dpdk-vdpa 
> > process,
> > after live migration, dest QEMU deadlock with dpdk-vdpa.
> > 
> > - QEMU sends VHOST_USER_SET_VRING_KICK to dpdk-vdpa net
> > - QEMU does not need to wait for a response to this message
> > - QEMU then sends VHOST_USER_SET_MEM_TABLE to dpdk-vdpa blk
> > - QEMU needs to wait reply in this message
> > - when dpdk-vdpa recv VHOST_USER_SET_VRING_KICK,
> > - it will send VHOST_USER_BACKEND_VRING_HOST_NOTIFIER_MSG to QEMU
> > - dpdk-vdpa needs to wait for a response to this message
> > - QEMU will deadlock with dpdk-vdpa
> > 
> > I tried to add a patch to the qemu community that uses a new thread to 
> > loop backend channel,
> > But there will be some multi-threaded synchronization issues
> > 
> > I think this is a public issue, and other backend messages take this 
> > into account,
> > so I think this message also needs a flag to fix it.
> > 
> > and jmnd vdpa driver will subsequently be open-sourced to the community.
> >   
> 
> Thanks forthe clarification.
> 
> Please submit this patch in the same series that introduce jmnd vDPA
> driver into upstream DPDK.
> 
> Indeed, we need to have an internal driver that makes use of this new op
> for it to be accepted. Otherwise, we have no way to maintain it.

Agree.
Marking this patch as rejected. Not going to add a hook that is not
used anywhere in the drivers in the repo. If you want to have out of
tree driver, then you have to keep your own out of tree changes
if it needs infrastructure changes.
