Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A7CAC02194
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Feb 2025 02:31:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E6D0402D5;
	Fri,  7 Feb 2025 03:31:14 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2056.outbound.protection.outlook.com [40.107.93.56])
 by mails.dpdk.org (Postfix) with ESMTP id CF332402A7;
 Fri,  7 Feb 2025 03:31:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J1Ldo8ZtQNenSJkPQnzDBQqQslc8DAuk8C9roObg61pkKLmuG919jW3/epvxO+n/7Dy2PyLFkHwl1z3GghYHDiyYKPFfEFBnXtnRS8re5dW+6uAHj8Vy2yLlCMZSEItsUXAo52+Q94P901HXK5xpI6F7RYt/nJ8Yq9/XKvHVJPAqc3bJnaa39e1V3mn6yUba7gwSgYoDg5MH5LOwh/NNX48YxApehqJ/o9M3EekspI+d21pAW+5FmlVUHHBdihhSxkB2fTEFZvBC3udGnKxuukU5iiSK4OXSX3dinQbrekTXQa6tsqFXPv8qoBFMeruv/gtvfr6CQB/TsMiwZGwL8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVTYHni+qSK9S5km5xM6PZxi2P1PHSeuys/poKVMEeI=;
 b=Cv1P1l8qN54zEAu88Xp1u/OiUBgaTWAINrAE0Xb+Z43E3GORF66TE083EIxKsoikIgwKHZV5CtU+gHdUcc1LTzhtd/g4DjUWQRyn8IvWYck7+weSwF6NPP5yReObDtJudijPRv8CAadR133tdWYHZraJp/fbAzreKRQ0E8TEAc5xd5pIk+99DG+Hqjx44JnY4PHsuCFK7cgGlqdr1QhhQ0WuLqFf/N06uFVFxkNIcLgm7ZCABP+m4Pdzr3aLk+S76yuFQm88r8Cr/2IlFH6ZsJEIf3Y0G/vyrjc5i//GnnbcfkO9moB3ewvwsK/FAdGwdjrnuIfBn6GzCSayJCVI3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVTYHni+qSK9S5km5xM6PZxi2P1PHSeuys/poKVMEeI=;
 b=gFgOM2udZiltRx/EHHwCBfaNgcDT9LOxQKhwAics3gg2BvPKzeZSm9ryW43+KXKfZDpPLZn0bhU8doorinLjOtG3JitgdZ1SVUNaOvXTyN4Q6pj/6ocTWThhWK+dBBp9fryd6R536xq1YXzFUyIYwjgsi+YXLsQ3qtz2YCiJDIsbYl10d50VpPE9rOHuFjbioNZKu7FaTNNd9vgYFSj9cYxdHGthO/dRV7YQbNA330QfWuRwTmfflY0oshIpLJ9QNgFjmu+/gRnYRq7HvrDQGMtgDrVihR13qA2sgaF+yOUCi+RJHKl0ZrQvERefZegci6cPSX3sriG87OEKesIE4Q==
Received: from MN0PR12MB6103.namprd12.prod.outlook.com (2603:10b6:208:3c9::19)
 by PH8PR12MB7255.namprd12.prod.outlook.com (2603:10b6:510:224::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Fri, 7 Feb
 2025 02:31:10 +0000
Received: from MN0PR12MB6103.namprd12.prod.outlook.com
 ([fe80::3c6c:6f63:917e:98d8]) by MN0PR12MB6103.namprd12.prod.outlook.com
 ([fe80::3c6c:6f63:917e:98d8%4]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 02:31:10 +0000
From: Chenbo Xia <chenbox@nvidia.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
CC: "dev@dpdk.org" <dev@dpdk.org>, "david.marchand@redhat.com"
 <david.marchand@redhat.com>, "stable@dpdk.org" <stable@dpdk.org>
Subject: Re: [PATCH] vhost: fix FD entries cleanup
Thread-Topic: [PATCH] vhost: fix FD entries cleanup
Thread-Index: AQHbeHMAHkLGy+KKfk6JDySnTNGBP7M7H7+A
Date: Fri, 7 Feb 2025 02:31:09 +0000
Message-ID: <343A31F4-DF95-48BB-8FA3-8BDBA1A2826D@nvidia.com>
References: <20250206084154.2230766-1-maxime.coquelin@redhat.com>
In-Reply-To: <20250206084154.2230766-1-maxime.coquelin@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB6103:EE_|PH8PR12MB7255:EE_
x-ms-office365-filtering-correlation-id: bda680f1-3a75-4e64-af76-08dd471f7b95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?us-ascii?Q?MMnLQCX9lCGRdDRldiFgY4VHJt2O34klNREvi5Bz/NXWw+epxONeMd2o09Dm?=
 =?us-ascii?Q?8KEvRlfO0ScoBtLyJGGk1jjCAPL/ji2fQwUO8O8orvjiuZ+vhWZNUKMuWYkh?=
 =?us-ascii?Q?OqIFJeMeylmqKMZoN5qbP2hZQvflP+HWziS6CspQBU/EXzwuLKFqoCG09mOK?=
 =?us-ascii?Q?r0FMpGsjVBtFgj1O36tAXtWjh2E+LJNOgTFTXDBu5u2DLUyKQZWl0BIKMxay?=
 =?us-ascii?Q?XgBIxGzNpRfPF6rj7TVd1QeLrqRV48mond5Wn3+N66J9q4x95l9m7vwpK3Tx?=
 =?us-ascii?Q?duz4N3hk1CnHmcRWfC6urCHFqQ7b77VE/4yXymXPC+DoX33WSw7SgP6xuWGz?=
 =?us-ascii?Q?fg5+dffw8MHyte3iOuH+wUGKPPqn8pXIeroyejoioWLnFLDuoGUzLJLyyIIS?=
 =?us-ascii?Q?7cZ/jEl59YNGG1xKW+rqdmU42c+WkiAzVBk/mANqZSZo/UTi4pytDEH/g3+j?=
 =?us-ascii?Q?MMoaBkoNgRfSyxx+z5mlTwHYryKZRHarCvhFY99sI1TakaminJQcyJ29bLpm?=
 =?us-ascii?Q?AhcCgzwmgZLxL3TbUHGo4WN5seDb1a8gX30jZliziNjFfJ0Kj/C86wxcMb9f?=
 =?us-ascii?Q?3/W6AVTFYkQ7J2wj7JhqX+GeGQZNUHmSGUnjxvAt9s2lZXfG919eyWzRLdrn?=
 =?us-ascii?Q?qd3IY4DjGoV12giWTIr2suDa53TFOssvLBfo5lrXnHpKhK+iHqs0avYVbauo?=
 =?us-ascii?Q?F80VXxnYNe0IrGSsG2bCa7m6z8/wKk5bvouLayalHHMamaNiz2xEU3tx0ECf?=
 =?us-ascii?Q?xsFx52ROkSZm5z0r62hTjYzsAih0VxybmjV+Y9ZWVHKlkicGZnNcGD/W2GEU?=
 =?us-ascii?Q?5crnFyOn5cCSlpHqxdwtKydi09f+0Rn6iZ77oz1MGuG0KPfqPSGBY+UThrEP?=
 =?us-ascii?Q?NLMjDMXzz6Vt4sjewqAau0AukRYbfTvh4lJ56zzO8AWNtAFodVtKsrCk8vnw?=
 =?us-ascii?Q?8N5h8T4hUX5G5euCMxmarLyQ/cs5B8tilzlWcWmQPIgOB2kJjrzVjyw0BiSC?=
 =?us-ascii?Q?nEHidPzB2TivPG+xOrnicrK53kOmhTHXslzBfLl9xiA9xnW1yJ0rR/VU/E2L?=
 =?us-ascii?Q?vlL1TGZLlRHMyJn/JT8zOeCx6rC34cWiGKdon89tVI5cXQGinzni/kBHufl0?=
 =?us-ascii?Q?vd3MVsAr3StgX1Cefg2pjkvZT2EVE94d8fDoYb4XpnOQr6dYIxPmj8FCo1cg?=
 =?us-ascii?Q?w40BEw8WRstDFYzD/oXkDEh99fT1vlfT8k4M9krCUwPSX60K+OM9kzgRfLMq?=
 =?us-ascii?Q?9/x/0MAocjK647LeeScYAIxlOiSXf2XpF9SlaGG3yHi5j/nsgriKpgl569T+?=
 =?us-ascii?Q?x2Tv8VqWurpux5Y2watnDbSAXg3YZj18FgM0F0jmFIhPjNRfffxiO6kj6c12?=
 =?us-ascii?Q?U9Qqh/kVD3awWOKakzEF8uKwlkLHy/Hek8piAXvWNe6WEK/ufHyPBdAqibPe?=
 =?us-ascii?Q?nH3ORwZZgAJzrmA2lUqrOvn1+uv6vg9B?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR12MB6103.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(38070700018); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KcKhh317LeEHooU8c7dj6O6j+7+JhyFtZh+nLUXI+aMSsGHSE7Xmhw9vFQAe?=
 =?us-ascii?Q?4e+PekDnVvHmkB9iqkzmO9VGRQ5b+ou17f9JZHuqF9Bsk65bmMcEkfeEEOi6?=
 =?us-ascii?Q?frfets31lZrmTmwqcYgvsmWVJKpPbUuj2S8aJzVpE8RsOhyFWLMLxb64nP4k?=
 =?us-ascii?Q?irhVdluxMqHlOBI2dsvGOK3RTbScgJhsn4rrGzhjLoQccT7B7fPxjsKfLwQ+?=
 =?us-ascii?Q?BkAVQyHL2bhUw5DSRkWEj6uBsPnnK7VMAB7/qsRcsHbKQUlqnzZRKeddrEOQ?=
 =?us-ascii?Q?zcEoWDdcMnk0h3kt60mqM0PeyIW8xtA2VT5CwUhD3IwF1k2R90OAXFS3rRXC?=
 =?us-ascii?Q?TDk0OTGXvJ7Fj0wfzEFLbjjOs/C69hKpo+Rmu65fxAdIURoUVneffTt3Hj43?=
 =?us-ascii?Q?ih82L9NUCXf0x6CZ9MBYOW2DXWI69WVdJ2JvucaFzlnqvFK7oGvzmgLIvJ3g?=
 =?us-ascii?Q?TAkZyFmvpMyPPCpe9RNMYgIWZHnheFGRRJpw30Awwia7io23/FUMHo9896C/?=
 =?us-ascii?Q?Rp/mkfi0uua//lbmLN3/HdvpFoAsySw+wa/FR0fyjDjC0V05WUAntZMA0OTd?=
 =?us-ascii?Q?ZS/ASSY8f2tmyGIisfsjVkJud7OgbUUsx499J0GaGR1tWm2PsmruClOVIJQl?=
 =?us-ascii?Q?0c6TfhD4ys9BvuI0UAjj8K/d1riT/IkjmK5snRcOieLQwae9pnrAMf0T3Ser?=
 =?us-ascii?Q?rHTM4a1E42HWJgd2qT1PGQ85fCHPSoMN0mFGn3qg/QlTw2k8WvkbHEDcb1Om?=
 =?us-ascii?Q?KjGiCYk416ic10dsNlbneg0892Zf/fiQtkbkWwVne+yQr8/b14T1+OLSiIhr?=
 =?us-ascii?Q?rs8Xv5UdPV1DrdtvFm/DWMH/3ENlDkaRqpnd9QUCxYnqluLZAgcvfF2m75s0?=
 =?us-ascii?Q?XBVjfdJHQ4YWnMM6xeDOoKXZUC/Lo1CXLckkpztxRkYoBIfFvKQsZZKRTQpR?=
 =?us-ascii?Q?Fn2o3Aihi3vJow1IV6bU7PMjW49Y0hq3kq5gCP9EpSVMBvNfgpqx/t9EMbK6?=
 =?us-ascii?Q?wpd9upoYgpvTCZ0uPI78xVKxaj3Y361tGa328Szao3laP9gBic4y1q16A9WP?=
 =?us-ascii?Q?bLVy9RCY991wJ2wSWHt6ySNE61N+W7w9PGyMHD5+wrfFoNY0lczutJC9HxKM?=
 =?us-ascii?Q?43vJ9zQfgcUqF6kpxfvjVbjSPfLFRmJDdIMDOuxJbLxBuZA9xhzXp9ysclAH?=
 =?us-ascii?Q?8BRFpmNetmTLJexy7CYgZ7aZ402zKaWRD4aH0GeOl448vWrMzaLBM9d4+Mqd?=
 =?us-ascii?Q?jBCdbes2/j+TXPVJmWCuCuNiSAGod72tXnLMPYs8//bvuH1gEAqJNYMuCufn?=
 =?us-ascii?Q?YXv8vCMnx79XPpQhpVIExeSyYF7AncxMnKvDxGqUbYlTFUD6rjRac3YLEu59?=
 =?us-ascii?Q?VwmdcWV90/YrVFn/zdtguVAFt02DoS6cX7LSJzdPzeJifZofneh3BALDPe33?=
 =?us-ascii?Q?Das30RGnduBDu7X0kkM4BZPQo/hIGeANHcwgZAeEdfkzPryOOu3uyFyVo41G?=
 =?us-ascii?Q?UKnE96G71WYxZGm76Cj/MYrMaxxbU2Q44aYc+UZlMBocmjoaHgsqSmxSvvbL?=
 =?us-ascii?Q?aShLtYsOmZAicL6Ei3ZHalC0bb9VhBqH+Pj//WlMKCY8PGf5uAE5b5HpLJFY?=
 =?us-ascii?Q?CA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <60389C5C7BA6EE44A2597FA67D200F2C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6103.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bda680f1-3a75-4e64-af76-08dd471f7b95
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 02:31:09.9117 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SjBZiWpVJeU5s6THnY2KNGe/psKNweF9ZtE8PCkpw451/gq67nXHZ6o8eifvaXGLzrhGr0Lw1GI0GuhOla7c/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7255
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



> On Feb 6, 2025, at 16:41, Maxime Coquelin <maxime.coquelin@redhat.com> wr=
ote:
>=20
> External email: Use caution opening links or attachments
>=20
>=20
> With the recent rework of the FD manager to use epoll,
> an error message is emitted with Vhost-user at FD entry
> removal:
>=20
> ERR|VHOST_FDMAN: could not remove 102 fd from 101 epfd: No such file or d=
irectory
>=20
> It occurs because the read callback closes the file
> descriptor before it is removed from the FD set.
> This patch defers the close() after the FD entry is removed
> from the set.
>=20
> Fixes: 0e38b42bf61c ("vhost: manage FD with epoll")
> Cc: stable@dpdk.org
>=20
> Signed-off-by: David Marchand <david.marchand@redhat.com>
> Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> ---
> lib/vhost/fd_man.c | 12 +++++++-----
> lib/vhost/fd_man.h |  2 +-
> lib/vhost/socket.c | 11 +++++------
> lib/vhost/vduse.c  |  9 ++++-----
> 4 files changed, 17 insertions(+), 17 deletions(-)
>=20
> diff --git a/lib/vhost/fd_man.c b/lib/vhost/fd_man.c
> index 9bc7e50b93..f9147edee7 100644
> --- a/lib/vhost/fd_man.c
> +++ b/lib/vhost/fd_man.c
> @@ -333,7 +333,7 @@ fdset_event_dispatch(void *arg)
>        fd_cb rcb, wcb;
>        void *dat;
>        int fd, numfds;
> -       int remove1, remove2;
> +       int close1, close2;
>        struct fdset *pfdset =3D arg;
>=20
>        if (pfdset =3D=3D NULL)
> @@ -357,7 +357,7 @@ fdset_event_dispatch(void *arg)
>                                continue;
>                        }
>=20
> -                       remove1 =3D remove2 =3D 0;
> +                       close1 =3D close2 =3D 0;
>=20
>                        rcb =3D pfdentry->rcb;
>                        wcb =3D pfdentry->wcb;
> @@ -367,9 +367,9 @@ fdset_event_dispatch(void *arg)
>                        pthread_mutex_unlock(&pfdset->fd_mutex);
>=20
>                        if (rcb && events[i].events & (EPOLLIN | EPOLLERR =
| EPOLLHUP))
> -                               rcb(fd, dat, &remove1);
> +                               rcb(fd, dat, &close1);
>                        if (wcb && events[i].events & (EPOLLOUT | EPOLLERR=
 | EPOLLHUP))
> -                               wcb(fd, dat, &remove2);
> +                               wcb(fd, dat, &close2);
>                        pfdentry->busy =3D 0;
>                        /*
>                         * fdset_del needs to check busy flag.
> @@ -381,8 +381,10 @@ fdset_event_dispatch(void *arg)
>                         * fdentry not to be busy, so we can't call
>                         * fdset_del_locked().
>                         */
> -                       if (remove1 || remove2)
> +                       if (close1 || close2) {
>                                fdset_del(pfdset, fd);
> +                               close(fd);
> +                       }
>                }
>=20
>                if (pfdset->destroy)
> diff --git a/lib/vhost/fd_man.h b/lib/vhost/fd_man.h
> index 6398343a6a..eadcc6fb42 100644
> --- a/lib/vhost/fd_man.h
> +++ b/lib/vhost/fd_man.h
> @@ -12,7 +12,7 @@ struct fdset;
>=20
> #define MAX_FDS 1024
>=20
> -typedef void (*fd_cb)(int fd, void *dat, int *remove);
> +typedef void (*fd_cb)(int fd, void *dat, int *close);
>=20
> struct fdset *fdset_init(const char *name);
>=20
> diff --git a/lib/vhost/socket.c b/lib/vhost/socket.c
> index 433a42bf80..b27020ae8d 100644
> --- a/lib/vhost/socket.c
> +++ b/lib/vhost/socket.c
> @@ -84,8 +84,8 @@ struct vhost_user {
>=20
> #define MAX_VIRTIO_BACKLOG 128
>=20
> -static void vhost_user_server_new_connection(int fd, void *data, int *re=
move);
> -static void vhost_user_read_cb(int fd, void *dat, int *remove);
> +static void vhost_user_server_new_connection(int fd, void *data, int *cl=
ose);
> +static void vhost_user_read_cb(int fd, void *dat, int *close);
> static int create_unix_socket(struct vhost_user_socket *vsocket);
> static int vhost_user_start_client(struct vhost_user_socket *vsocket);
>=20
> @@ -290,7 +290,7 @@ vhost_user_add_connection(int fd, struct vhost_user_s=
ocket *vsocket)
>=20
> /* call back when there is new vhost-user connection from client  */
> static void
> -vhost_user_server_new_connection(int fd, void *dat, int *remove __rte_un=
used)
> +vhost_user_server_new_connection(int fd, void *dat, int *close __rte_unu=
sed)
> {
>        struct vhost_user_socket *vsocket =3D dat;
>=20
> @@ -303,7 +303,7 @@ vhost_user_server_new_connection(int fd, void *dat, i=
nt *remove __rte_unused)
> }
>=20
> static void
> -vhost_user_read_cb(int connfd, void *dat, int *remove)
> +vhost_user_read_cb(int connfd, void *dat, int *close)
> {
>        struct vhost_user_connection *conn =3D dat;
>        struct vhost_user_socket *vsocket =3D conn->vsocket;
> @@ -313,8 +313,7 @@ vhost_user_read_cb(int connfd, void *dat, int *remove=
)
>        if (ret < 0) {
>                struct virtio_net *dev =3D get_device(conn->vid);
>=20
> -               close(connfd);
> -               *remove =3D 1;
> +               *close =3D 1;
>=20
>                if (dev)
>                        vhost_destroy_device_notify(dev);
> diff --git a/lib/vhost/vduse.c b/lib/vhost/vduse.c
> index 8ba58555f9..9d39e71c68 100644
> --- a/lib/vhost/vduse.c
> +++ b/lib/vhost/vduse.c
> @@ -117,7 +117,7 @@ static struct vhost_backend_ops vduse_backend_ops =3D=
 {
> };
>=20
> static void
> -vduse_control_queue_event(int fd, void *arg, int *remove __rte_unused)
> +vduse_control_queue_event(int fd, void *arg, int *close __rte_unused)
> {
>        struct virtio_net *dev =3D arg;
>        uint64_t buf;
> @@ -350,7 +350,7 @@ vduse_device_stop(struct virtio_net *dev)
> }
>=20
> static void
> -vduse_events_handler(int fd, void *arg, int *remove __rte_unused)
> +vduse_events_handler(int fd, void *arg, int *close __rte_unused)
> {
>        struct virtio_net *dev =3D arg;
>        struct vduse_dev_request req;
> @@ -563,14 +563,13 @@ vduse_reconnect_log_check(struct virtio_net *dev, u=
int64_t features, uint32_t to
> }
>=20
> static void
> -vduse_reconnect_handler(int fd, void *arg, int *remove)
> +vduse_reconnect_handler(int fd __rte_unused, void *arg, int *close)
> {
>        struct virtio_net *dev =3D arg;
>=20
>        vduse_device_start(dev, true);
>=20
> -       close(fd);
> -       *remove =3D 1;
> +       *close =3D 1;
> }
>=20
> static int
> --
> 2.48.1
>=20

Reviewed-by: Chenbo Xia <chenbox@nvidia.com>

