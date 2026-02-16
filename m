Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A14E83840
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Feb 2026 22:24:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B96B40289;
	Mon, 16 Feb 2026 23:24:12 +0100 (CET)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46]) by mails.dpdk.org (Postfix) with ESMTP id BCC5E4026C
 for <dev@dpdk.org>; Mon, 16 Feb 2026 23:24:10 +0100 (CET)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-436356740e6so4291012f8f.2
 for <dev@dpdk.org>; Mon, 16 Feb 2026 14:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771280650;
 x=1771885450; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzocSu/mbNdSrGoJ822Nv51qmmAB+6m9Kcw2eZPE/5c=;
 b=TOIEa7Ux8d3Cwtd1GZvGHdCMFOOx0/zui/Od2u3MNZWD6jXdDTDt3T3Ov1xy36WzDg
 8KLV1g84JRoUxU6bBHQksOD1PIPvAMJ9pEseQwFaQ71/oydgwAzVJfH5yvKzY+88EAiO
 5q4bQYy99xpGiidk+ewhSGZnryBR9RmrKmk3cV/A6aOmNeXMvsqgDv5oLRDoWX0dfimh
 ot3S6mye3C/ny3k2duxv1JHs940spaF6/h8GEoez0vp2tm1kWuIiARIDHjBsZVD62ApF
 7w0/poPrhu90LdtXXBBtWOLYDnAzHTc41bTVv0i6jzmhLtbvlNJn5gaO/djF4J3y0MLt
 85hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771280650; x=1771885450;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yzocSu/mbNdSrGoJ822Nv51qmmAB+6m9Kcw2eZPE/5c=;
 b=ScyHUmGtm1M7j3EpLajjx7mEgGM4tsJ1MXvdYeug38jYFhtiQ0opvCA6fkUoTH6IvK
 3A0VUCIrsPMxf+5OMQ/RzOpwL0vv/bIN6VKFxEyyKO0DjjMLiBjfD4oPiDMs2BNAWbgs
 uDw9i7jxxGUUz60hbhC1YAfDyTOkjTt1B1CTb8//hksuYpBUn4+4KZAzTDRaq0Tn948W
 NLnUi+qC0M8pu4ayOOwiEVLIsrvlxSgXmAZzbl9NdBJjkstiLggLsp/fKtKzydQoWAw4
 p5bocHQe+UpgegDZhmoezf926cdNmyzToPxAM0P0SPVVJHcR3gVBhRLhV7B4e2Fcr6L5
 Mtcw==
X-Gm-Message-State: AOJu0Yx/MBYTU55yML3BVJdQCQiN57tvRPdzSAQE8rEBhyDliVLxcdAj
 EOqL0LS9cuspZ+h+Wj96iel6FleM45LpJ/LFVTLkX944BtJX6wa61KvlvD7ubbIMGRk=
X-Gm-Gg: AZuq6aL0c3gR+mm6fB89K87aAo9ThzhM9rSYrqJnlj+y0EJAS0TKmlOfXnqQSGpWXHg
 211Ub7rTSAwLEN0X6UwW01ZYN92aLZuMHzuExijuKW9D82VwVmqoRwUFJCHLwuWm13twz4pELMU
 80/zNv/ZNTObrFbgpdA38vlXP7YQR4xVAZmzIXCOtelZ/iq8/1GNJpSCG1IHPgTIiEc6drVH/E1
 pQvX/O4GfGSTjy2Wsug1iN0ZAlUA1yp4f2UtlHMesM15kJsL1XHsQE4LKIAjPt3ttVEIw6MFEzu
 vnjVPtaWcsKXLtgh7rcMfjfi5wxvIy+DJ5IjkL27dRoIWm0oCt1oGFklF+ZsbLV9Xi7XSZWDbPk
 P5i/oNI9/zfFWVzoAp5K7PHh1UjYxeq03xH3cbwty66aDVXDn07/9pmkALo5YeKrF/BUqn4K6L8
 4WkqM0JHJy1MMoMgCxfLE31245+bfhL0W8dTWSmJWOfhAcaK6N58PFCmX4z26pKf0A
X-Received: by 2002:a05:6000:288e:b0:430:f5ed:83e3 with SMTP id
 ffacd0b85a97d-4379db31b5amr13374458f8f.6.1771280650218; 
 Mon, 16 Feb 2026 14:24:10 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796a6a5e5sm28276520f8f.9.2026.02.16.14.24.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Feb 2026 14:24:10 -0800 (PST)
Date: Mon, 16 Feb 2026 14:24:05 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: Re: [PATCH v4 22/27] net/iavf: avoid rte malloc in queue operations
Message-ID: <20260216142405.1a1ba2fd@phoenix.local>
In-Reply-To: <869fa36c643d5f9da0bd4992fc179914eff53a93.1770978324.git.anatoly.burakov@intel.com>
References: <cover.1770978324.git.anatoly.burakov@intel.com>
 <869fa36c643d5f9da0bd4992fc179914eff53a93.1770978324.git.anatoly.burakov@intel.com>
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

On Fri, 13 Feb 2026 10:26:33 +0000
Anatoly Burakov <anatoly.burakov@intel.com> wrote:

> Currently, when enabling, disabling, or switching queues, we are using
> rte_malloc followed by an immediate rte_free. This is not needed as these
> structures are not being stored anywhere, so replace them with stack
> allocation or malloc/free where appropriate.
>=20
> Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>

AI caught something here.

Patch 22/27 =E2=80=94 net/iavf: avoid rte malloc in queue operations
Error (Correctness =E2=80=94 Uninitialized stack memory)

In iavf_switch_queue_lv(), the stack-allocated queue_req is not zero-initia=
lized:

=EF=BF=BC
c
	} queue_req;   /* <-- no "=3D {0}" */
The original code used rte_zmalloc which zeroes the buffer. The other two f=
unctions in this same patch (iavf_enable_queues_lv and iavf_disable_queues_=
lv) correctly use =3D {0}, but iavf_switch_queue_lv does not. The structure=
 is then sent as a virtchnl message via args.in_args, meaning uninitialized=
 stack bytes will be transmitted to the PF driver. While individual fields =
like num_chunks, vport_id, queue_type, start_queue_id, and num_queues are s=
et explicitly, padding bytes and any other fields within the struct will co=
ntain garbage.

Additionally, this function previously allocated only sizeof(struct virtchn=
l_del_ena_dis_queues) (which includes exactly 1 chunk), but the new stack s=
truct includes IAVF_RXTX_QUEUE_CHUNKS_NUM - 1 additional chunks. Since num_=
chunks is set to 1, the extra space is harmless =E2=80=94 but passing sizeo=
f(queue_req) as in_args_size now sends a larger buffer than before. Compare=
 with the enable/disable functions which also have the extra chunks but act=
ually use IAVF_RXTX_QUEUE_CHUNKS_NUM chunks. The size change is likely beni=
gn but worth noting.

Fix: Add =3D {0} to the declaration, matching the pattern in the sibling fu=
nctions in the same patch:

=EF=BF=BC
c
	} queue_req =3D {0};
