Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD0EC87FCB
	for <dpdk-dev@archiver.kernel.org>; Thu, 31 Jul 2025 00:14:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E68F402DB;
	Thu, 31 Jul 2025 02:14:01 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 1EE094026A
 for <dev@dpdk.org>; Thu, 31 Jul 2025 02:14:00 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-af51596da56so230579a12.0
 for <dev@dpdk.org>; Wed, 30 Jul 2025 17:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1753920839; x=1754525639; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Wn2YqrtF1TgImGGDgS3vs7dIhmA8UsNvEg/9zR73N5M=;
 b=jatv5AoNMEGXPpJgtg4ZwJIhc0AXJyVVr8J93KwQ3nQx2QkcZJriGBDyNyWP11Lz0N
 ykFFSonNjqhxNxsU5dvxj0iJ4XDCZ1njMIZU97qhrvveCohwJ/phMSUpXOwXBSJ48NOD
 HWScBBzLtD+jZNKpCSS36GForLlO2Qs0J061c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753920839; x=1754525639;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Wn2YqrtF1TgImGGDgS3vs7dIhmA8UsNvEg/9zR73N5M=;
 b=JWVIVlYxYRoW0/slfIlZveo7GNQ1+XBQGCaiOsXTqNlZV5ViCNDYhaaG0m0mPAzi6h
 uOa1pRIszaVp/BNRy+Iy5D7Fw9RdOCzvVsE2cmH2nTeASpsvvZH5eZtWuZ5g4FGsC8c4
 C5135Dgkr1M0vxaOP59JzKeDafs6oDi1wUNCQoowfRfxWkiHmE9NqnMpbfz/MJ+Cw9CY
 QULhfv1U8wBJGZl+WLChLLbO0Ogf4r7Jr+gqz3TNCmwstM6YCS+QN1I6CeFvUMnO/78K
 /K/9hjfkuw8QEVLTQA+UQahaxQa+OAPOkcMtwvWy+i6PkIERdNvPPK/Yhzw9JBCs4VW3
 IYdA==
X-Gm-Message-State: AOJu0YzD6aT+5ARzg4aWLcDzMXi+FLqEZ11uKke3LyfXBXpgq6fpk6nK
 Efdgynl4Y8koayJ/WLgsHjrgnln5Pv1lSQ7XHd7GvvAcQdxG8VTVOCbZRo0t08VsugoW1RsYBIn
 nH5c7iLbAn32BsZ4YE6lMSp2sAO5OLNau3jsB7nWoTnBywpjblXgkmMQ=
X-Gm-Gg: ASbGncuLgLiSQl9qJcXq7c8M1orQnaAHmx0r9Pu6ZrBxiJP47fdxVqtFn2IvHQgSWqZ
 fe1rnKVA7nmRIBWDJlQkUvenNN1HisWkyyq7cJqfo49TeqT2lzW/jmXr6oBY/Z2eWhD+3d2Ypmw
 jXZmnCQZ4ODmPND4oPWuaG8wtMGCKq9lU3j2qdJbTlOfHm36hVmDuIUdR9LjZqDsdutYQuI7onA
 bt8rg2Qoq21SlaK1IOTtA==
X-Google-Smtp-Source: AGHT+IG7KHcincp6v8qZikSNEhooI7/1rmXhxXbOUC0UTvKpDvMkCEWTrRAAyFAbql07Qq3C8hzlUi0wkSyRw626BcI=
X-Received: by 2002:a17:90b:3c4f:b0:31f:e6e:7313 with SMTP id
 98e67ed59e1d1-31f5dd6fd4cmr7199992a91.3.1753920839026; Wed, 30 Jul 2025
 17:13:59 -0700 (PDT)
MIME-Version: 1.0
From: Patrick Robb <probb@iol.unh.edu>
Date: Wed, 30 Jul 2025 20:07:51 -0400
X-Gm-Features: Ac12FXwlGmzJ1KK6vBbIIHJxR8fLGEt1jGaoOSFt0dTRkVy2jIfNokIorhQk_Y8
Message-ID: <CAJvnSUB2scYCkV4BKFyxHVpPLFmhLYVb20tV0LFDeUHLWfVW+Q@mail.gmail.com>
Subject: DTS 25.11 Roadmap
To: dev <dev@dpdk.org>
Cc: ci@dpdk.org, Luca Vizzarro <Luca.Vizzarro@arm.com>, 
 Paul Szczepanek <Paul.Szczepanek@arm.com>, Dean Marx <dmarx@iol.unh.edu>, 
 Manit Mahajan <mmahajan@iol.unh.edu>, Andrew Bailey <abailey@iol.unh.edu>, 
 Bruce Richardson <bruce.richardson@intel.com>
Content-Type: multipart/alternative; boundary="00000000000093270e063b2e8483"
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

--00000000000093270e063b2e8483
Content-Type: text/plain; charset="UTF-8"

Hello,

The DTS group has met and agreed on the top level goals for 25.11 DTS
development.

DTS Roadmap:
   * DTS API
      * Provide a single point of entry into the framework for all test
suites, allowing stable usage across releases and user friendly
discoverability of dts functionality
   * Packet Forwarding Performance Tests
   * Cryptodev testing
      * (framework): Adding a shell class for the dpdk-crypto-perf
application
      * (testsuites) : Encrypt/decrypt workloads with the various supported
algorithms on DPDK NICs.
         * Can be implemented as a set of functional tests or (pending
community discussion) can support crypto performance baselines
   * Testing with single NIC with the 2 interfaces connected in a loopback
      * This appears to be working currently, but need to be documented
better for users
   * Virtio testing support:
      * Add support for DTS spinning up a QEMU VM with a virtio device
      * Implement various testing scenarios for virtio interfaces on a VM
   * Additional functional ethdev testsuites:
      * Ethertype Testsuite
      * QinQ Testsuite
      * RSS Testsuite
      * Rx/Tx Offload
      * And additional suites as detailed on Bugzilla where possible
   * File manager:
      * Add a dedicated file manager to handle passing files and artifacts

--00000000000093270e063b2e8483
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div><br></div><div>The DTS group has met=
 and agreed on the top level goals for 25.11 DTS development.</div><div><br=
></div><div>DTS Roadmap:</div><div>=C2=A0 =C2=A0* DTS API<br>=C2=A0 =C2=A0 =
=C2=A0 * Provide a single point of entry into the framework for all test su=
ites, allowing stable usage across releases and user friendly discoverabili=
ty of dts functionality<br>=C2=A0 =C2=A0* Packet Forwarding Performance Tes=
ts<br>=C2=A0 =C2=A0* Cryptodev testing <br>=C2=A0 =C2=A0 =C2=A0 * (framewor=
k): Adding a shell class for the dpdk-crypto-perf application<br>=C2=A0 =C2=
=A0 =C2=A0 * (testsuites) : Encrypt/decrypt workloads with the various supp=
orted algorithms on DPDK NICs.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* Can b=
e implemented as a set of functional tests or (pending community discussion=
) can support crypto performance baselines<br>=C2=A0 =C2=A0* Testing with s=
ingle NIC with the 2 interfaces connected in a loopback<br>=C2=A0 =C2=A0 =
=C2=A0 * This appears to be working currently, but need to be documented be=
tter for users<br>=C2=A0 =C2=A0* Virtio testing support:<br>=C2=A0 =C2=A0 =
=C2=A0 * Add support for DTS spinning up a QEMU VM with a virtio device<br>=
=C2=A0 =C2=A0 =C2=A0 * Implement various testing scenarios for virtio inter=
faces on a VM<br>=C2=A0 =C2=A0* Additional functional ethdev testsuites:<br=
>=C2=A0 =C2=A0 =C2=A0 * Ethertype Testsuite<br>=C2=A0 =C2=A0 =C2=A0 * QinQ =
Testsuite<br>=C2=A0 =C2=A0 =C2=A0 * RSS Testsuite<br>=C2=A0 =C2=A0 =C2=A0 *=
 Rx/Tx Offload<br>=C2=A0 =C2=A0 =C2=A0 * And additional suites as detailed =
on Bugzilla where possible<br>=C2=A0 =C2=A0* File manager:<br>=C2=A0 =C2=A0=
 =C2=A0 * Add a dedicated file manager to handle passing files and artifact=
s</div></div>

--00000000000093270e063b2e8483--
