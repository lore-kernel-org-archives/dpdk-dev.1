Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ADA1094489
	for <dpdk-dev@archiver.kernel.org>; Sat, 21 Mar 2026 17:44:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 662A8402DB;
	Sat, 21 Mar 2026 18:44:47 +0100 (CET)
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
 by mails.dpdk.org (Postfix) with ESMTP id AABDC402C9
 for <dev@dpdk.org>; Sat, 21 Mar 2026 18:44:45 +0100 (CET)
Received: by mail-dl1-f52.google.com with SMTP id
 a92af1059eb24-12732165d1eso3815558c88.1
 for <dev@dpdk.org>; Sat, 21 Mar 2026 10:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774115085;
 x=1774719885; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YrhUtZClIgbdZoo9tNkP0t0Rkm554BXF6TOzSL8qPKY=;
 b=1A/VkuJOjW+LKXBCjmS/bm+NqRARzCXWoUkm3L9CIlw24IRejgtJ8jst856lPvF38o
 JVkvwOkYfd/Lj2rPC1G+XE3wkePDrc6QtSToXVTP1X9gdGQAdA1kGwnEUkS8DJfZD010
 nvVsqZO+TvSpeqkxi/ZsoiOIgd0A2cr0kmwnujpEyzIaqT+Ef0xAh8Lwf9Bpk4pEMq3F
 gALu2jqYzpojlB6vuwZAFxrfBwU/s3F5q96AWwCYYRRmVINwnA4WynoZKFLN6Cd+P2Mu
 VWJoZ1Z4cBP9M2M+aUprfvb/nDwHAsZFQOy379f9IEozGKAGjaJ+I3ucPMWJw+IjoSDt
 45oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774115085; x=1774719885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YrhUtZClIgbdZoo9tNkP0t0Rkm554BXF6TOzSL8qPKY=;
 b=I/WvhSkHZoaAL4f5ysomUY6RXYJMDuFJdD5fJ+xdG7hOrUYFdT0lqs/Tjl/FY6spn6
 2CLpd5ARpNyA6bGC+QxU++l4nr8elDBRecUVG2VFPtVrboHDOLYlJjNNjoXs3Pa1zcP3
 6gTG+5iXf/7Ecn2JpaPZtpcjw7hzPzcAUa8eDQ/ky6ui5krjIabgaju3kyx7H9CjqNyW
 SFPBLbWXOaG2whDU+2W288tHiz3FpQw0Zi33DZQCvHzbDqg+cfvw83SOQ+XAukj+YZNk
 CDix89siZYIy2e79T3bUOwb7PavFehK2YN18e/klCk9VJeAhDHQzGBZ4yvxFEm2Wjtqg
 O2GA==
X-Gm-Message-State: AOJu0YzJvmtp+4miUi4txnDWLNicwEvtPdGMbGDD57u5lhhzzzxIaIL/
 5AgvxXGazTT7XhPpGpc0drW3KtQ5JWLPVLkDjLwGF/X6C2MPE7/d8touDb7LblaNssQ=
X-Gm-Gg: ATEYQzw8IlFNxJh/a8dzdR8KkN5kHNhjMwedWWJzErkOcbmkchmN2IdjcjF8nda8wRY
 bJDiXWoPdRa4rhwiCW2CqRV0GY/o5ib1uoyKDv/4l0t9n81h5+UfsaN0fPoP07GOUNpCQCXTQGz
 n3W9M3pcGHL2WOKCmR0/iwpFMLEpan6AJLPqwWz8pQdZWi4jeNJDoCftVSwliFtHQeoPY51P8kJ
 caU2Sa4Mpne9uBUqUKyyR8a8BPY6fK1JoTGbIExo2r1b81vbJNxohmrWYkC7WrHVSvmsBMcez1d
 ROA2Ao93PMlYjRq9LHciXneayrWqagXP8I0ShknKqzG77scukkFU2qNd4Vf5DUiEdsYL64Oa8u5
 ADmmguKFPUChTSL+tlJhypCMWvKYtHW0Z8cWLNYdhAkZ+Q5uJuBZMZ6M/n06AqTSlYnKwErLjMw
 vW7Fz/LR4iOa0l+QUCKNtk//uvYwwRQLQ+iJM=
X-Received: by 2002:a05:7022:b85:b0:128:d9a1:b68b with SMTP id
 a92af1059eb24-12a726be762mr2813787c88.33.1774115084522; 
 Sat, 21 Mar 2026 10:44:44 -0700 (PDT)
Received: from phoenix.local ([104.202.29.139])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b2cf068sm7430873eec.22.2026.03.21.10.44.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Mar 2026 10:44:44 -0700 (PDT)
Date: Sat, 21 Mar 2026 10:44:40 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Long Li <longli@microsoft.com>
Cc: dev@dpdk.org, Wei Hu <weh@microsoft.com>, stable@dpdk.org
Subject: Re: [PATCH] net/netvsc: switch data path to synthetic on device stop
Message-ID: <20260321104440.7e853b61@phoenix.local>
In-Reply-To: <20260321004337.1608222-1-longli@microsoft.com>
References: <20260321004337.1608222-1-longli@microsoft.com>
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

On Fri, 20 Mar 2026 17:43:37 -0700
Long Li <longli@microsoft.com> wrote:

> When DPDK stops a netvsc device (e.g. on testpmd quit), the data path
> was left pointing to the VF/MANA device. If the kernel netvsc driver
> subsequently reloads the MANA device and opens it, incoming traffic
> arrives on the MANA device immediately, before the queues are fully
> initialized. This causes bogus RX completion events to appear on the
> TX completion queue, triggering a kernel WARNING in mana_poll_tx_cq().
>=20
> Fix this by switching the data path back to synthetic (via
> NVS_DATAPATH_SYNTHETIC) in hn_vf_stop() before stopping the VF device.
> This tells the host to route traffic through the synthetic path, so
> that when the MANA driver recreates its queues, no unexpected traffic
> arrives until netvsc explicitly switches back to VF.
>=20
> Also update hn_vf_start() to switch the data path back to VF after the
> VF device is started, enabling correct stop/start cycling.
>=20
> Both functions now use write locks instead of read locks since they
> modify vf_vsc_switched state.
>=20
> Fixes: dc7680e8597c ("net/netvsc: support integrated VF")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: Long Li <longli@microsoft.com>

Looks good to me you might want to address the error condition
spotted by AI review.

---

**Patch: net/netvsc: switch data path to synthetic on device stop**

This patch addresses a real race condition where stopping a netvsc device l=
eaves the data path pointing to the VF/MANA device, causing kernel warnings=
 when the MANA driver later reinitializes. The fix is logically sound =E2=
=80=94 switch to synthetic before stopping the VF, and re-switch to VF on s=
tart.

**Error: `hn_vf_stop()` =E2=80=94 `vf_vsc_switched` cleared even when `hn_n=
vs_set_datapath()` fails**

In `hn_vf_stop()`, if `hn_nvs_set_datapath(hv, NVS_DATAPATH_SYNTHETIC)` fai=
ls, `vf_vsc_switched` is unconditionally set to `false`. This means the dri=
ver believes it switched to synthetic when the host may still be routing tr=
affic through the VF. On a subsequent `hn_vf_start()`, the `!hv->vf_ctx.vf_=
vsc_switched` check will pass and the driver will try to re-switch to VF =
=E2=80=94 but since the host never left VF mode, this is a no-op at best or=
 confusing at worst. More importantly, if stop is being called on the path =
to teardown, the flag is now wrong.

I note that `hn_vf_remove_unlocked()` has the same pattern (clears the flag=
 regardless, with the comment "Clear switched flag regardless =E2=80=94 VF =
is being removed"), so this may be intentional for netvsc since on the remo=
ve path you want to forget the state. But on the stop path the device is st=
ill present and will be restarted =E2=80=94 propagating the error and leavi=
ng `vf_vsc_switched =3D true` might be more correct so that `hn_vf_start()`=
 retries the switch. Worth confirming this is intentional.

**Warning: `hn_vf_start()` =E2=80=94 error from `hn_nvs_set_datapath()` ret=
urned but VF device left started**

In `hn_vf_start()`, if `rte_eth_dev_start()` succeeds but the subsequent `h=
n_nvs_set_datapath(hv, NVS_DATAPATH_VF)` fails, the function logs the error=
 and returns the failure code. However, the VF device is left in the starte=
d state. The caller sees a failure from `hn_vf_start()`, but the VF is runn=
ing with no traffic routed to it. This is a resource consistency issue =E2=
=80=94 if the datapath switch fails, should the VF be stopped again to main=
tain consistent state?

**Warning: `hn_vf_add_unlocked()` =E2=80=94 change defers datapath switch b=
ut still returns 0 on the deferred path**

The patch modifies `hn_vf_add_unlocked()` to skip the datapath switch when =
`!dev->data->dev_started`. This is correct, but note that in the original c=
ode the function would return the result of `hn_nvs_set_datapath()` =E2=80=
=94 if that failed, it returned an error. Now on the deferred path, `ret` r=
etains whatever value it had from the attach/configure path (could be 0 fro=
m a successful attach), so the caller gets success even though the datapath=
 switch was not attempted. This is fine for the hot-add-before-start case, =
just noting the behavior change.

**Info: Lock upgrade from read to write is correct**

Both `hn_vf_start()` and `hn_vf_stop()` correctly switch from `rte_rwlock_r=
ead_lock` to `rte_rwlock_write_lock` since they now modify `vf_vsc_switched=
`. This matches the locking pattern used by `hn_vf_close()` and `hn_nvs_han=
dle_vfassoc()`.
