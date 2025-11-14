Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6664ECE8D50
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 16:19:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A688740ED8;
	Fri, 14 Nov 2025 17:19:41 +0100 (CET)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com
 [209.85.128.177])
 by mails.dpdk.org (Postfix) with ESMTP id E250940151
 for <dev@dpdk.org>; Fri, 14 Nov 2025 17:19:39 +0100 (CET)
Received: by mail-yw1-f177.google.com with SMTP id
 00721157ae682-78933de9ab5so5030427b3.1
 for <dev@dpdk.org>; Fri, 14 Nov 2025 08:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1763137179; x=1763741979; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=60brjLutsrHyWXIsDBEFNX3jO9G6NSIX7nzk4efY/E0=;
 b=f6vH4GeSqlygHY+e7BBJWiWtLEdKrehZyULCOe5fMGp3SGC7F0n/QTpUUKa+NtF2yo
 ArmrluRSarak1Ad5usGlmlFGb/Ra17JH11xjv1qePFfQrG8DzX+5EJh2X1Wa7hohekin
 r7flYWMT+Zff8QngoRIKT3mkpIMM9tlRVWjHQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763137179; x=1763741979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=60brjLutsrHyWXIsDBEFNX3jO9G6NSIX7nzk4efY/E0=;
 b=ZXMTl5c0MecCEeq7jSSeJcVi4fvNCYAPH3f7GZb7S3VLUx9lNLBdJx74h95JYwUJlL
 Ka2PfUo2RKGC3xAgqA9kW4cHtnqvVjRswdyLdLuUPJu3VFfHteK8eBFZUCW2uhD/TCjI
 nr28w4qKYTvAu5L5FZAE/yfAP4aFTPpqVbjt3ChJy0pdSBSN4FIlR6mx087k61Mp21f7
 O5Lc1yuncZFFwk4ycXD9n0wmaDyFIGSuEA4VdtHPcE2IPLOjfvDbNQ4bM7YdXuuuVXYM
 y7ISMXmauUot2lkfLeaxDLMBO3SgjOuM+QNHd+KJlbAoJXtDnRpZKD3n6Vaoe5SLMfBQ
 sXQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7A5VKw5Q8t9mkhBxrUqWg4oIP9BuOGsmWfFY7rqYaMeqVjyaxDg1c3MSLeepjVkrbDq0=@dpdk.org
X-Gm-Message-State: AOJu0Yy9SdyXeFofOocVtDTLiYSbNDV0+eWSq2R03qHQDFLlQl+VDzqk
 ZACAmCJyuQG4JL9GLR422Bz/Gh0+MwNdQtQer9mzMlfp5qH5RlD2C7sSBlJO1/E0mXD1Yz7AS1+
 7QMCXkEQ9hmbP+38hZQE5jR14nM+yvfTqm6DinCY5IQ==
X-Gm-Gg: ASbGncvshzmSuJTUkyTt3gaic4xQoG5BTUhA0HjhCMWOdxPe5fbROMv0wuMi6um41UV
 ZqYtG8oeKld4iZyfM6t6sk3OZkKKUMZGWnknTR9rNcJ1BpquO2Qlsk4Bsj6k1nP9NPz69R6qKCR
 IHFMMIDrEYv33bdNfmWI2wf2i+ymIXERSZz2CyvskS8pJeRYN4I8VeUZ35M+1Bzg8bma4OOs+RO
 8VVRSIc3+1PshMpjqiM23RmP0L1XIHqpMUvyFHmnuZ1iszS3uizBf1W1Gm6ILHJpnE8s5wPk1gb
 k3sZWoKLcci7to5WayqA
X-Google-Smtp-Source: AGHT+IHy0F6v9562wJKSopc/l5FpsANwQEJ5R9eES/HGFCSro3+ClKIvN9sgNWj+Lh1nNlSwb4iESZH67D/A9sN3tBw=
X-Received: by 2002:a05:690c:6087:b0:786:5926:edb3 with SMTP id
 00721157ae682-78929f09b00mr36818277b3.45.1763137179266; Fri, 14 Nov 2025
 08:19:39 -0800 (PST)
MIME-Version: 1.0
References: <20251024181606.604135-2-dmarx@iol.unh.edu>
 <20251113190309.310821-1-dmarx@iol.unh.edu>
 <20251113190309.310821-2-dmarx@iol.unh.edu>
 <CAJvnSUB+21qM1c5pHOnNSaUhiXdQtREv4rzbFu5exe8ZMnU8dw@mail.gmail.com>
In-Reply-To: <CAJvnSUB+21qM1c5pHOnNSaUhiXdQtREv4rzbFu5exe8ZMnU8dw@mail.gmail.com>
From: Dean Marx <dmarx@iol.unh.edu>
Date: Fri, 14 Nov 2025 11:19:28 -0500
X-Gm-Features: AWmQ_blqOk1aAgRtCIT1u4qcYzNjbxDSvpKoYDuLMQcnYD1uObGu4xCxKONuoZo
Message-ID: <CABD7UXPPqRsJa-7fKLBpSxSbsum1AE5pUWkmvObLfh9_fKGGUw@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] dts: add QinQ test suite
To: Patrick Robb <probb@iol.unh.edu>
Cc: luca.vizzarro@arm.com, yoan.picchi@foss.arm.com, 
 Honnappa.Nagarahalli@arm.com, paul.szczepanek@arm.com, dev@dpdk.org
Content-Type: text/plain; charset="UTF-8"
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

Yes, I'll resubmit ASAP
